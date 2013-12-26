require_relative "../../../test_helper"

module Troo
  describe RefreshAll do
    let(:described_class) { RefreshAll }
    let(:options) { { } }

    before do
      @board = Fabricate(:board)
      @list = Fabricate(:list)
      @card = Fabricate(:card)
      Troo::BoardRetrieval.stubs(:current).returns(@board)
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(options) }

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe ".perform" do
      subject { described_class.perform(options) }

      before do
        ExternalBoard.stubs(:fetch_all).returns([@board])
        ExternalList.stubs(:fetch).returns([@list])
        ExternalCard.stubs(:fetch).returns([@card])
        ExternalComment.stubs(:fetch).returns([])
        ExternalMember.stubs(:fetch).returns([])
      end

      it "returns true when successful" do
        subject.must_equal(true)
      end
    end

    describe ".lists" do
      before { VCR.insert_cassette(:refresh_lists_by_board_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.lists(options, external_board_id) }

      context "when an external_board_id is provided" do
        let(:external_board_id) { "526d8e130a14a9d846001d96" }

        it "refreshes the lists for the board specified" do
          subject.size.must_equal(4)
        end
      end

      context "when a current board is set" do
        let(:external_board_id) { }

        it "refreshes the lists for the current board" do
          subject.size.must_equal(4)
        end
      end
    end

    describe "#cards" do
      before { VCR.insert_cassette(:refresh_cards_by_board_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.cards(options, external_board_id) }

      context "when an external_board_id is provided" do
        let(:external_board_id) { "526d8e130a14a9d846001d96" }

        it "refreshes the cards for the board specified" do
          subject.size.must_equal(9)
        end
      end

      context "when a current board is set" do
        let(:external_board_id) { }

        it "refreshes the cards for the current board" do
          subject.size.must_equal(9)
        end
      end
    end
  end
end
