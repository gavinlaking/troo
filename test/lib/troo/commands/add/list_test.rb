require_relative "../../../../test_helper"

module Troo
  module Commands
    module Add
      describe List do
        let(:described_class) { List }
        let(:value) { }
        let(:id)    { }

        describe "#initialize" do
          subject { described_class.new(value, id) }

          it "assigns the value to an instance variable" do
            subject.instance_variable_get("@value").must_equal(value)
          end

          it "assigns the id to an instance variable" do
            subject.instance_variable_get("@id").must_equal(id)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(value, id) }

          it "will be tested by the integration tests" do
            skip
          end
        end
      end
    end
  end
end
