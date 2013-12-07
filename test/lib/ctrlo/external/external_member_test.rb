require_relative "../../../test_helper"

module Ctrlo
  describe ExternalMember do
    let(:described_class) { ExternalMember }

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
      before { VCR.insert_cassette(:members_by_board_id) }
      after  { VCR.eject_cassette }

      let(:board_id) { "526d8e130a14a9d846001d96" }
      let(:options)  { { mode: :board } }

      subject { described_class.fetch(board_id, options) }

      it "returns multiple members" do
        subject.size.must_equal(2)
      end
    end

    describe "when the mode is member" do
      before { VCR.insert_cassette(:member_by_member_id) }
      after  { VCR.eject_cassette }

      let(:member_id) { "5195fdb5a8c01a2318004f5d" }
      let(:options)   { { mode: :member } }

      subject { described_class.fetch(member_id, options) }

      it "returns a member with the member_id" do
        subject.size.must_equal(1)
      end
    end
  end
end
