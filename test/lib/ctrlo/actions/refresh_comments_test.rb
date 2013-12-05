require_relative "../../../test_helper"

module Ctrlo
  describe RefreshComments do
    let(:described_class) { RefreshComments }

    describe ".initialize" do
      let(:board_id) { "some_board_id" }
      let(:options) { {} }

      subject { described_class.new(board_id, options) }

      it "assigns the board_id" do
        subject.instance_variable_get("@board_id").
          must_equal("some_board_id")
      end

      it "assigns the options" do
        subject.instance_variable_get("@options").
          must_equal({})
      end
    end

    describe "#refresh" do
    end
  end
end
