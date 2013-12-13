require_relative "../../../test_helper"

module Troo
  describe ExternalBoard do
    let(:described_class) { ExternalBoard }
    let(:board_id)        { "526d8e130a14a9d846001d96" }
    let(:options)         { { } }

    describe ".initialize" do
      subject { described_class.new(board_id, options) }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal(board_id)
      end

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe ".fetch" do
      before { VCR.insert_cassette(:board_by_id) }
      after  { VCR.eject_cassette }

      subject { described_class.fetch(board_id, options) }

      it "returns a single board" do
        subject.size.must_equal(1)
      end

      it "returns a board with the board_id" do
        subject.first.external_board_id.must_equal(board_id)
      end

      it "returns a board with the correct name" do
        subject.first.name.must_equal("Troo App")
      end
    end

    describe ".fetch_all" do
      before { VCR.insert_cassette(:boards_all, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.fetch_all }

      it "returns multiple boards" do
        subject.size.must_equal(2)
      end
    end
  end
end
