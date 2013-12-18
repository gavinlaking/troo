require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Current do
      let(:described_class) { Current }

      describe "#board" do
        let(:board_id) { "some_board_id" }

        subject { capture_io { described_class.new.board(board_id) }.join }

        context "when the board_id cannot be found" do
          before do
            Troo::BoardRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            subject.must_match /Board cannot be found./
          end
        end

        context "when the board_id was found" do
          let(:board) { Troo::Board.new(name: "My Board", current: false) }

          before do
            Troo::BoardRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(board)
          end

          it "reports success" do
            subject.must_match /Board 'My Board' set to current./
          end
        end
      end

      describe "#card" do
        let(:card_id) { "some_card_id" }

        subject { capture_io { described_class.new.card(card_id) }.join }

        context "when the card_id cannot be found" do
          before do
            Troo::CardRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            subject.must_match /Card cannot be found./
          end
        end

        context "when the card_id was found" do
          let(:card) { Troo::Card.new(name: "My Card", current: false) }

          before do
            Troo::CardRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(card)
          end

          it "reports success" do
            subject.must_match /Card 'My Card' set to current./
          end
        end
      end

      describe "#list" do
        let(:list_id) { "some_list_id" }

        subject { capture_io { described_class.new.list(list_id) }.join }

        context "when the list_id cannot be found" do
          before do
            Troo::ListRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            subject.must_match /List cannot be found./
          end
        end

        context "when the list_id was found" do
          let(:list) { Troo::List.new(name: "My List", current: false) }

          before do
            Troo::ListRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(list)
          end

          it "reports success" do
            subject.must_match /List 'My List' set to current./
          end
        end
      end
    end
  end
end
