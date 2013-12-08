require_relative "../../../test_helper"

module Ctrlo
  describe Card do
    let(:described_class) { Card }

    describe ".current" do
      subject { described_class.current }

      before do
        described_class.stubs(:first).returns(current_card)
      end

      describe "when current is set" do
        let(:current_card) { Ctrlo::Card.new(current: true) }

        it "returns the current card" do
          subject.must_equal current_card
        end
      end

      describe "when current is not set" do
        let(:current_card) { nil }

        it "raises an exception" do
          proc { subject }.must_raise(StandardError)
        end
      end
    end

    describe "#members" do
      subject { described_class.new.members }

      it "" do
        skip
      end
    end
  end
end

