require_relative "../../../test_helper"

module Troo
  describe Adaptors::Board do
    let(:described_class) { Adaptors::Board }
    let(:resource) { OpenStruct.new({
      id:          "526d8e130a14a9d846001d96",
      name:        "My Test Board",
      description: "A very brief description...",
      closed:      false,
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
          external_board_id: "526d8e130a14a9d846001d96",
          name:              "My Test Board",
          description:       "A very brief description...",
          closed:            "false",
        })
      end
    end
  end
end
