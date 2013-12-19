require_relative "../../../test_helper"

module Troo
  describe MemberRetrieval do
    let(:described_class) { MemberRetrieval }

    before do
      Ohm.redis.flushdb
    end

    describe ".retrieve" do
      before do
        @member = Troo::Member.create({
                  full_name:          "My Test Member",
                  external_member_id: "5195fdb5a8c01a2318004f5d" })
      end

      after do
        @member.delete
      end

      context "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored members" do
          subject.size.must_equal 1
        end
      end

      context "with an ID" do
        subject { described_class.retrieve(id) }

        context "local retrieval by database ID" do
          let(:id) { @member.id }

          it "returns the correct member" do
            subject.full_name.must_equal("My Test Member")
          end
        end

        context "local retrieval by external ID" do
          let(:id) { "5195fdb5a8c01a2318004f5d" }

          it "returns the correct member" do
            subject.full_name.must_equal("My Test Member")
          end
        end

        context "remote retrieval by either ID" do
          before do
            @member.delete
            ExternalMember.stubs(:fetch).returns(remote_member)
          end

          let(:id) { "526d_remote_member_005259" }
          let(:remote_member) { [Troo::Member.new({
                                 full_name:          "My Remote Test Member",
                                 external_member_id: id })] }

          it "returns the correct member" do
            subject.full_name.must_equal("My Remote Test Member")
          end
        end
      end
    end
  end
end
