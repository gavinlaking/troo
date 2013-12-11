require_relative "../../../test_helper"
require "thor"

module Ctrlo
  module CLI
    describe Current do
      let(:described_class) { Current }

      describe "#board" do
        let(:board_id) { "some_board_id" }

        subject { described_class.new.board(board_id) }

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

      describe "#card" do
        let(:card_id) { "some_card_id" }

        subject { described_class.new.card(card_id) }

        describe "when the card_id cannot be found" do
          before do
            Ctrlo::CardRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            proc { subject }.must_output("Card cannot be found.\n")
          end
        end

        describe "when the card_id was found" do
          let(:card) { Ctrlo::Card.new(name: "My Card", current: false) }

          before do
            Ctrlo::CardRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(card)
          end

          it "reports success" do
            proc { subject }.must_output("Card 'My Card' set to current.\n")
          end
        end
      end

      describe "#list" do
        let(:list_id) { "some_list_id" }

        subject { described_class.new.list(list_id) }

        describe "when the list_id cannot be found" do
          before do
            Ctrlo::ListRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            proc { subject }.must_output("List cannot be found.\n")
          end
        end

        describe "when the list_id was found" do
          let(:list) { Ctrlo::List.new(name: "My List", current: false) }

          before do
            Ctrlo::ListRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(list)
          end

          it "reports success" do
            proc { subject }.must_output("List 'My List' set to current.\n")
          end
        end
      end
    end
  end
end
