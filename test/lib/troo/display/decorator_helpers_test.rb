require_relative "../../../test_helper"

class DecoratorHelpersDummy
  include Troo::DecoratorHelpers
end

module Troo
  describe DecoratorHelpers do
    let(:described_class) { DecoratorHelpersDummy }
    let(:described_instance) { described_class.new }

    describe "#title" do
      before do
        described_instance.stubs(:default).returns("*")
        described_instance.stubs(:id).returns(67)
        described_instance.stubs(:name).returns("My Test Dummy")
        described_instance.stubs(:options).returns({})
      end

      subject { described_instance.title }

      it "returns a formatted string representing the card title" do
        subject.must_match /\* \(67\) My Test Dummy/
      end
    end
  end
end
