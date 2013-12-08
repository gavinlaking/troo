require_relative "../../../test_helper"

module Ctrlo
  describe Board do
    let(:described_class) { Board }

    describe ".current" do
      subject { described_class.current }

      before do
        described_class.stubs(:first).returns(current_board)
      end

      describe "when current is set" do
        let(:current_board) { Ctrlo::Board.new(current: true) }

        it "returns the current board" do
          subject.must_equal current_board
        end
      end

      describe "when current is not set" do
        let(:current_board) { nil }

        it "raises an exception" do
          proc { subject }.must_raise(StandardError)
        end
      end
    end
  end
end

