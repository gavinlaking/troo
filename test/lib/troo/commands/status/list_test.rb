require_relative "../../../../test_helper"

module Troo
  module Commands
    module Status
      describe List do
        let(:described_class) { List }

        describe ".dispatch" do
          subject { described_class.dispatch }

          it "will be tested by the integration tests" do
            skip
          end
        end
      end
    end
  end
end
