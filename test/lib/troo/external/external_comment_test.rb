require_relative "../../../test_helper"

module Troo
  describe ExternalComment do
    let(:described_class) { ExternalComment }
    let(:options) { {} }

    before do
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new("some_id", options) }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal("some_id")
      end

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "when the mode is board" do
      before { VCR.insert_cassette(:comments_by_board_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      let(:board_id) { "526d8e130a14a9d846001d96" }
      let(:options)  { { mode: :board } }

      subject { described_class.fetch(board_id, options) }

      it "returns multiple comments" do
        subject.size.must_equal(20)
      end

      context "when the board cannot be found" do
        before { Trello::Board.stubs(:find).raises(Trello::Error) }

        it "returns an empty collection" do
          subject.must_equal([])
        end
      end
    end

    describe "when the mode is list" do
      before { VCR.insert_cassette(:comments_by_list_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      let(:list_id) { "526d8e130a14a9d846001d97" }
      let(:options) { { mode: :list } }

      subject { described_class.fetch(list_id, options) }

      it "returns comments with the list_id" do
        subject.size.must_equal(0)
      end

      context "when the list cannot be found" do
        before { Trello::List.stubs(:find).raises(Trello::Error) }

        it "returns an empty collection" do
          subject.must_equal([])
        end
      end
    end

    describe "when the mode is card" do
      before { VCR.insert_cassette(:comments_by_card_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      let(:card_id) { "526d8f19ddb279532e005259" }
      let(:options) { { mode: :card } }

      subject { described_class.fetch(card_id, options) }

      it "returns a comment with the card_id" do
        subject.size.must_equal(11)
      end

      context "when the card cannot be found" do
        before { Trello::Card.stubs(:find).raises(Trello::Error) }

        it "returns an empty collection" do
          subject.must_equal([])
        end
      end
    end
  end
end
