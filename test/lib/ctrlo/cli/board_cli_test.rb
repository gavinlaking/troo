require_relative "../../../test_helper"
require "thor"

module Ctrlo
  module CLI
    describe Board do
      let(:described_class) { Board }
      let(:board_id) { "some_board_id" }

      describe "#all" do
        subject { described_class.new.all }

        before do
          Ctrlo::BoardRetrieval.stubs(:retrieve).returns(boards)
        end

        describe "when there are boards to be shown" do
          let(:boards) { [Ctrlo::Board.new(id: 1, name: "My Test Board 1"),
                          Ctrlo::Board.new(id: 2, name: "My Test Board 2")] }

          it "outputs a list of boards" do
            proc { subject }.must_output <<-OUTPUT.gsub(/^ {14}/, "")
              \e[4m\e[31m1\e[0m My Test Board 1
              \e[4m\e[31m2\e[0m My Test Board 2

            OUTPUT
          end
        end

        describe "when there are no boards to be shown" do
          let(:boards) { nil }

          it "shows an error" do
            proc { subject }.must_output("No boards found.\n")
          end
        end
      end

      describe "#show" do
        subject { described_class.new.show(board_id) }

        describe "when the board_id cannot be found" do
          let(:board) { nil }

          before do
            Ctrlo::BoardRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            proc { subject }.must_output("Board cannot be found.\n")
          end
        end

        describe "when the board_id was found" do
          let(:lists) { [ Ctrlo::List.new(id: 1, name: "My Test List 1", cards: cards) ] }
          let(:cards) { [ Ctrlo::Card.new(id: 1, name: "My Test Card 1") ] }
          let(:board) { Ctrlo::Board.new(id: 1, name: "My Test Board 1", lists: lists) }

          before do
            Ctrlo::BoardRetrieval.stubs(:retrieve).returns(board)
          end

          it "outputs the board including lists and cards" do
            proc { subject }.must_output <<-OUTPUT.gsub(/^ {14}/, "")
              \e[4m\e[31m1\e[0m My Test Board 1
                  \e[4m\e[33m1\e[0m My Test List 1
                      \e[4m\e[34m\e[0m My Test Card 1

            OUTPUT
          end
        end
      end
    end
  end
end
