require_relative "../../../../test_helper"

module Troo
  module Remote
    describe Resource do
      let(:described_class) { Resource }
      let(:json) { "{\"some_key\":\"some_value\"}" }

      describe "#initialize" do
        subject { described_class.new(json) }

        it "assigns the JSON to an instance variable" do
          subject.instance_variable_get("@json").must_equal(json)
        end
      end

      describe ".create" do
        subject { described_class.create(json) }

        it "returns the resource" do
          subject.must_be_instance_of described_class
        end
      end
    end
  end
end
