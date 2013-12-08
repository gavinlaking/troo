require_relative "../../../test_helper"

module Ctrlo
  describe Card do
    let(:described_class) { Card }

    describe ".current" do
      subject { described_class.current }

      describe "when current is set" do
        it "" do
          skip
        end
      end

      describe "when current is not set" do
        before do
          described_class.stubs(:first) { nil }
        end

        it "raises an exception" do
          proc { subject }.must_raise(StandardError)
        end
      end
    end

    describe "#members" do
      subject { described_class }

      it "" do
        skip
      end
    end
  end
end

