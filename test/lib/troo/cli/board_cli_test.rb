require_relative "../../../test_helper"

module Troo
  module CLI
    describe Board do
      let(:described_class) { Board }
      let(:board_id)        { "526d8e130a14a9d846001d96" }
      let(:list_id)         { "526d8e130a14a9d846001d97" }
      let(:card_id)         { "526d8f19ddb279532e005259" }

      before do
        database_cleanup
        @board = Troo::Board.create({
          name: "My Test Board",
          external_board_id: board_id,
          current: false
        })
        @board_2 = Troo::Board.create({
          name: "My Other Board",
          current: true
        })
        @list = Troo::List.create({
          name: "My Test List",
          external_board_id: board_id,
          external_list_id: list_id
        })
        @card = Troo::Card.create({
          name: "My Test Card",
          external_list_id: list_id,
          external_card_id: card_id
        })
      end

      after do
        @board.delete
        @board_2.delete
        @list.delete
        @card.delete
      end

      describe ".all" do
        subject { capture_io { described_class.new.all }.join }

        context "when boards exist" do
          it "returns a list of boards" do
            subject.must_match /Test Board/
            subject.must_match /Other Board/
          end
        end

        context "when no boards exist" do
          before do
            Troo::BoardRetrieval.stubs(:retrieve).returns([])
          end

          it "returns a polite message" do
            subject.must_match /Boards not found./
          end
        end
      end

      describe ".show" do
        subject { capture_io { described_class.new.show(board_id) }.join }

        context "when the board exists" do
          it "returns the board with all lists and all cards" do
            subject.must_match /Test Board/
            subject.must_match /Test List/
            subject.must_match /Test Card/
          end
        end

        context "when the board does not exist" do
          before do
            Troo::BoardRetrieval.stubs(:retrieve).returns()
          end

          it "returns a polite message" do
            subject.must_match /Board not found./
          end
        end
      end
    end
  end
end
