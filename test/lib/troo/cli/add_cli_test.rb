require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Add do
      let(:described_class) { Add }
      let(:create_board) { OpenStruct.new(name: "My New Test Board") }
      let(:create_card)  { OpenStruct.new(name: "My New Test Card") }
      let(:create_list)  { OpenStruct.new(name: "My New Test List") }

      before do
        Troo::CreateBoard.stubs(:with).returns(create_board)
        Troo::CreateCard.stubs(:for).returns(create_card)
        Troo::CreateList.stubs(:for).returns(create_list)

        Troo::ExternalBoard.stubs(:fetch_all)
        Troo::ExternalCard.stubs(:fetch)
        Troo::ExternalList.stubs(:fetch)
      end

      after do
        database_cleanup
      end

      describe "#board" do
        let(:board_name) { "My New Test Board" }

        subject { capture_io { described_class.new.board(board_name) }.join }

        it "creates a board and returns a polite message" do
          subject.must_match /New board 'My New Test Board' created/
        end
      end

      describe "#card" do
        let(:list_id)     { "526d8e130a14a9d846001d97" }
        let(:card_name)   { "My New Test Card" }
        let(:description) { "A very brief description..." }

        subject { capture_io { described_class.new.card(list_id, card_name, description) }.join }

        it "creates a card and returns a polite message" do
          subject.must_match /New card 'My New Test Card' created/
        end
      end

      describe "#list" do
        let(:board_id)  { "526d8e130a14a9d846001d96" }
        let(:list_name) { "My New List" }

        subject { capture_io { described_class.new.list(board_id, list_name) }.join }

        it "creates a list and returns a polite message" do
          subject.must_match /New list 'My New Test List' created/
        end
      end
    end
  end
end
