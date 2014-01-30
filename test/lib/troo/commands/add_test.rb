require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    module Commands
      describe Add do
        let(:described_class) { Add }

        describe "#initialize" do
          let(:type)  { }
          let(:value) { }
          let(:id)    { }

          subject { described_class.new(type, value, id) }

          it "assigns the type to an instance variable" do
            subject.instance_variable_get("@type").must_equal(type)
          end

          it "assigns the value to an instance variable" do
            subject.instance_variable_get("@value").must_equal(value)
          end

          it "assigns the id to an instance variable" do
            subject.instance_variable_get("@id").must_equal(id)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(type, id) }

          it "will be tested by the integration tests" do
            skip
          end
        end
      end
    end
  end
end
