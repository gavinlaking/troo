require_relative "../../../test_helper"

module Ctrlo
  describe ExternalMember do
    let(:described_class) { ExternalMember }

    describe ".initialize" do
      subject { described_class.new("some_id") }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal "some_id"
      end
    end

    describe "when the mode is board" do
      before { VCR.insert_cassette(:members_by_board_id) }
      after  { VCR.eject_cassette }
    end

    describe "when the mode is member" do
      before { VCR.insert_cassette(:member_by_member_id) }
      after  { VCR.eject_cassette }
    end
  end
end
