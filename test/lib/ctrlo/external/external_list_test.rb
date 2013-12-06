require_relative "../../../test_helper"

module Ctrlo
  describe ExternalList do
    let(:described_class) { ExternalList }

    describe ".initialize" do
      subject { described_class.new("some_id", {}) }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal "some_id"
      end

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal({})
      end
    end

    describe "when the mode is board" do
      before { VCR.insert_cassette(:lists_by_board_id) }
      after  { VCR.eject_cassette }

      let(:board_id) { "526d8e130a14a9d846001d96" }
      let(:options)  { { mode: :board } }

      subject { described_class.fetch_by_external_id(board_id, options) }

      it "returns a list with the board_id" do
        skip
      end
    end

    describe "when the mode is list" do
      before { VCR.insert_cassette(:list_by_list_id) }
      after  { VCR.eject_cassette }

      let(:list_id) { "526d8e130a14a9d846001d97" }
      let(:options) { { mode: :list } }

      subject { described_class.fetch_by_external_id(list_id, options) }

      it "returns a list with the list_id" do
        skip
      end
    end
  end
end
