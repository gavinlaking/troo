require_relative "../../../../test_helper"

module Troo
  module Commands
    module Refresh
      describe Board do
        let(:described_class) { Board }
        let(:id) { }

        describe "#initialize" do
          subject { described_class.new(id) }

          it "assigns the id to an instance variable" do
            subject.instance_variable_get("@id").must_equal(id)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(id) }

          it "will be tested by the integration tests" do
            skip
          end
        end
      end
    end
  end
end
