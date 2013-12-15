require_relative "../../../test_helper"

class ModelHelpersDummy
  include Troo::ModelHelpers
end

module Troo
  describe ModelHelpersDummy do
    let(:described_class) { ModelHelpersDummy }

    describe "#external_attributes" do
      subject { described_class.new.external_attributes }

      it "" do
        skip
      end
    end
  end
end
