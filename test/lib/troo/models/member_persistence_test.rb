require_relative "../../../test_helper"

module Troo
  describe MemberPersistence do
    let(:described_class) { MemberPersistence }

    before do
      database_cleanup
      @member = Troo::Member.create({
        full_name:          "My Test Member",
        external_member_id: "5195fdb5a8c01a2318004f5d"
      })
    end

    after do
      @member.delete
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource) { OpenStruct.new({
          id:        "5195fdb5a8c01a2318004f5d",
          full_name: "My Test Member"
        }) }

        it "returns the local copy" do
          subject.must_equal(@member)
        end
      end

      context "when the local copy is out of date" do
        let(:resource) { OpenStruct.new({
          id:        "5195fdb5a8c01a2318004f5d",
          full_name: "My Renamed Member"
        }) }

        it "updates and returns the new local copy" do
          subject.full_name.must_equal("My Renamed Member")
        end
      end

      context "when there is no local copy" do
        before do
          @member.delete
        end

        let(:resource) { OpenStruct.new({
          id:        "5195fdb5a8c01a2318004f5d",
          full_name: "My New Test Member"
        }) }

        it "creates and returns the new local copy" do
          subject.full_name.must_equal("My New Test Member")
        end
      end
    end
  end
end

