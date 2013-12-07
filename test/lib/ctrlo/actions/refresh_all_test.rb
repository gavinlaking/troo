require_relative "../../../test_helper"

module Ctrlo
  describe RefreshAll do
    let(:described_class) { RefreshAll }

    describe ".initialize" do
      subject { described_class.new(options) }

      let(:options) { { } }

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#perform" do
      subject { described_class }

      it "" do
        skip
      end
    end
  end
end
