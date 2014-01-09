require_relative "../../../test_helper"

module Troo
  describe ExternalCard do
    let(:described_class) { ExternalCard }
    let(:card_id) { "526d8f19ddb279532e005259" }
    let(:options) { {} }

    before { @card = Fabricate(:card) }
    after  { database_cleanup }

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
      before { VCR.insert_cassette(:cards_by_board_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      let(:board_id) { "526d8e130a14a9d846001d96" }
      let(:options)  { { mode: :board, comments: false } }

      subject { described_class.fetch(board_id, options) }

      it "returns multiple cards" do
        subject.size.must_equal(2)
      end

      context "when the board cannot be found" do
        before { Trello::Board.stubs(:find).raises(Trello::Error) }

        it "returns an empty collection" do
          subject.must_equal([])
        end
      end
    end

    describe "when the mode is list" do
      before { VCR.insert_cassette(:cards_by_list_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      let(:list_id) { "526d8e130a14a9d846001d97" }
      let(:options) { { mode: :list, comments: false } }

      subject { described_class.fetch(list_id, options) }

      it "returns multiple cards" do
        subject.size.must_equal(1)
      end

      context "when the list cannot be found" do
        before { Trello::List.stubs(:find).raises(Trello::Error) }

        it "returns an empty collection" do
          subject.must_equal([])
        end
      end
    end

    describe "when the mode is card" do
      before { VCR.insert_cassette(:card_by_card_id, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      let(:card_id) { "526d8f19ddb279532e005259" }
      let(:options) { { mode: :card, comments: false } }

      subject { described_class.fetch(card_id, options) }

      it "returns a single card" do
        subject.size.must_equal(1)
      end

      context "when the card cannot be found" do
        before { Trello::Card.stubs(:find).raises(Trello::Error) }

        it "returns an empty collection" do
          subject.must_equal([])
        end
      end
    end

    describe "when the comments options is enabled" do
      before do
        Trello::Card.stubs(:find).returns(resource)
        ExternalComment.stubs(:fetch)
      end

      let(:resource) { OpenStruct.new(id: "526d8f19ddb279532e005259") }
      let(:options) { { mode: :card, comments: true } }

      subject { described_class.fetch(card_id, options) }

      it "fetches the comments for the card" do
        subject.size.must_equal(1)
      end
    end
  end
end
