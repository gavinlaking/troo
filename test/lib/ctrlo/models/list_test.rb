require_relative "../../../test_helper"

module Ctrlo
  describe List do
    let(:described_class) { List }

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
  end
end
