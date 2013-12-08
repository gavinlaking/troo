require_relative "../../../test_helper"
require "thor"

module Ctrlo
  module CLI
    describe Board do
      let(:described_class) { Board }

      describe "#all" do
        subject { described_class }

        it "" do
          skip
        end
      end

      describe "#current" do
        let(:board_id) { "some_board_id" }

        subject { described_class.new.current(board_id) }

        describe "when the board_id cannot be found" do
          before do
            Ctrlo::BoardRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            proc { subject }.must_output("Board cannot be found.\n")
          end
        end

        describe "when the board_id was found" do
          let(:board) { Ctrlo::Board.new(name: "My Board", current: false) }

          before do
            Ctrlo::BoardRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(board)
          end

          it "reports success" do
            proc { subject }.must_output("Board 'My Board' set to current.\n")
          end
        end
      end

      describe "#show" do
        subject { described_class }

        it "" do
          skip
        end
      end
    end
  end
end
