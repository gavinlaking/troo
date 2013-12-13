require_relative "../../../test_helper"

module Troo
  describe ExternalCard do
    let(:described_class) { ExternalCard }

    describe ".initialize" do
      subject { described_class.new("some_id", {}) }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal("some_id")
      end

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal({})
      end
    end

    describe "when the mode is board" do
      before { VCR.insert_cassette(:cards_by_board_id) }
      after  { VCR.eject_cassette }

      let(:board_id) { "526d8e130a14a9d846001d96" }
      let(:options)  { { mode: :board } }

      subject { described_class.fetch(board_id, options) }

      it "returns multiple cards" do
        subject.size.must_equal(9)
      end
    end

    describe "when the mode is list" do
      before { VCR.insert_cassette(:cards_by_list_id) }
      after  { VCR.eject_cassette }

      let(:list_id) { "526d8e130a14a9d846001d97" }
      let(:options) { { mode: :list } }

      subject { described_class.fetch(list_id, options) }

      it "returns multiple cards" do
        subject.size.must_equal(5)
      end
    end

    describe "when the mode is card" do
      before { VCR.insert_cassette(:card_by_card_id) }
      after  { VCR.eject_cassette }

      let(:card_id) { "526d8f19ddb279532e005259" }
      let(:options) { { mode: :card } }

      subject { described_class.fetch(card_id, options) }

      it "returns a single card" do
        subject.size.must_equal(1)
      end
    end
  end
end
