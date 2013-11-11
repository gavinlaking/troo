require_relative "../../../test_helper"

module Trlo
  describe Member do
  end

  describe FindMember do
    describe ".with" do
      let(:member_id) { "some_24bit_member_id" }

      subject { Member.with(member_id) }

      it "finds the member by member_id" do
        skip("Please write spec.")
      end
    end
  end
end

