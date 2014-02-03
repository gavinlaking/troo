require_relative "../../../test_helper"

module Troo
  describe Adaptors::Card do
    let(:described_class) { Adaptors::Card }
    let(:resource) { OpenStruct.new({
      board_id:           "526d8e130a14a9d846001d96",
      list_id:            "526d8e130a14a9d846001d97",
      id:                 "526d8f19ddb279532e005259",
      member_ids:         ["5195fdb5a8c01a2318004f5d"],
      short_id:           67,
      name:               "My Test Card",
      desc:               "some description",
      url:                "some trello url",
      pos:                16,
      last_activity_date: "2013-12-17 21:48:09 UTC",
      closed:             false,
    }) }

    describe "#initialize" do
      subject { described_class.new(resource) }

      it "assigns the resource to an instance variable" do
        subject.instance_variable_get("@resource").must_equal(resource)
      end
    end

    describe "#adapted" do
      subject { described_class.adapt(resource) }

      it "returns an adapted resource suitable for local persistence" do
        subject.must_equal({
          external_board_id:   "526d8e130a14a9d846001d96",
          external_list_id:    "526d8e130a14a9d846001d97",
          external_card_id:    "526d8f19ddb279532e005259",
          external_member_ids: "[\"5195fdb5a8c01a2318004f5d\"]",
          short_id:            "67",
          name:                "My Test Card",
          desc:                "some description",
          url:                 "some trello url",
          position:            "16",
          last_activity_date:  "2013-12-17 21:48:09 UTC",
          closed:              "false",
        })
      end
    end
  end
end
