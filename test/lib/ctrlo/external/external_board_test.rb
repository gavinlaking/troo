require_relative "../../../test_helper"

module Ctrlo
  describe ExternalBoard do
    let(:described_class) { ExternalBoard }
    let(:board_id) { "526d8e130a14a9d846001d96" }

    describe ".initialize" do
      subject { described_class.new(board_id) }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal(board_id)
      end
    end

    describe "#fetch" do
      before { VCR.insert_cassette(:boards_all, :decode_compressed_response => true) }
      after  { VCR.eject_cassette }

      subject { described_class.fetch }

      it "returns multiple boards" do
        skip
      end
    end

    describe "#fetch_by_external_id" do
      before { VCR.insert_cassette(:board_by_id) }
      after  { VCR.eject_cassette }

      subject { described.fetch_by_external_id(board_id) }

      it "returns a board with the board_id" do
        skip
      end
    end
  end
end
