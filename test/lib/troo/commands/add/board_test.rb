require_relative "../../../../test_helper"

module Troo
  module Commands
    module Add
      describe Board do
        let(:described_class) { Board }
        let(:value) { }

        describe "#initialize" do
          subject { described_class.new(value) }

          it "assigns the value to an instance variable" do
            subject.instance_variable_get("@value").must_equal(value)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(value) }

          it "will be tested by the integration tests" do
            skip
          end
        end
      end
    end
  end
end
