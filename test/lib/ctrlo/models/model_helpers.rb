require_relative "../../../test_helper"

class ModelHelpersDummy
  include Ctrlo::ModelHelpers
end

module Ctrlo
  describe ModelHelpersDummy do
    let(:described_class) { ModelHelpersDummy }

    describe "#internal_attributes" do
      subject { described_class.new.internal_attributes }

      it "" do
        skip
      end
    end

    describe "#external_attributes" do
      subject { described_class.new.external_attributes }

      it "" do
        skip
      end
    end
  end
end
