require_relative "../../../test_helper"

module Ctrlo
  describe ExternalBoard do
    let(:described_class) { ExternalBoard }

    describe ".initialize" do
      subject { described_class.new("some_id") }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal "some_id"
      end
    end

    describe "#fetch" do
      before { VCR.insert_cassette(:boards_all) }
      after  { VCR.eject_cassette }
    end

    describe "#fetch_by_external_id" do
      before { VCR.insert_cassette(:board_by_id) }
      after  { VCR.eject_cassette }
    end
  end
end
