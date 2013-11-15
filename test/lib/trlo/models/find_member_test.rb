require_relative "../../../test_helper"

module Trlo
  describe FindMember do
    describe ".with" do
      subject { FindMember.with("5195fdb5a8c01a2318004f5d") }

      before do
        VCR.insert_cassette(:find_member)
      end

      after do
        VCR.eject_cassette
      end

      it "finds the member by specified member_id" do
        subject.full_name.must_equal "Gavin Laking"
      end
    end
  end
end
