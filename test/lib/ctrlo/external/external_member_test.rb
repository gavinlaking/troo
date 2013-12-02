require_relative "../../../test_helper"

module Ctrlo
  describe ExternalMember do
    # describe "when the is_member_id option is set" do
    #   before { VCR.insert_cassette(:member_singular) }
    #   after  { VCR.eject_cassette }

    #   it "returns an individual member" do
    #     Ctrlo::ExternalMember.request("526d8f19ddb279532e005259", {is_member_id: true}).size must_equal 1
    #   end
    # end

    # describe "when the is_member_id option is not set" do
    #   before { VCR.insert_cassette(:member_collection) }
    #   after  { VCR.eject_cassette }

    #   it "returns a collection of members" do
    #     Ctrlo::ExternalMember.request("526d8e130a14a9d846001d96").size must_equal 17
    #   end
    # end
  end
end
