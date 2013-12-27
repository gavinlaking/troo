require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Add do
      let(:described_class) { Add }

      before do
        @board = Fabricate(:board, name: "My New Test Board")
        @card = Fabricate(:card, name: "My New Test Card")
        @comment = Fabricate(:comment)
        @list = Fabricate(:list, name: "My New Test List")

        Troo::CreateBoard.stubs(:with).returns(@board)
        Troo::CreateCard.stubs(:for).returns(@card)
        Troo::CreateComment.stubs(:for).returns(@comment)
        Troo::CreateList.stubs(:for).returns(@list)
      end

      after do
        database_cleanup
      end

      describe "#board" do
        let(:board_name) { "My New Test Board" }

        subject { capture_io { described_class.new.board(board_name) }.join }

        context "when the name was not provided" do
          let(:board_name) { }

          before { $stdin.stubs(:gets).returns(@board.name) }

          it "prompts the user" do
            subject.must_match /enter a name/
          end
        end

        context "when the board was created" do
          it "returns a polite message" do
            subject.must_match /New board '#{@board.name}' created/
          end
        end

        context "when the board was not created" do
          before { Troo::CreateBoard.stubs(:with).returns(false) }

          it "returns a polite message" do
            subject.must_match /Board could not be created/
          end
        end
      end

      describe "#card" do
        let(:list_id)     { "526d8e130a14a9d846001d97" }
        let(:card_name)   { "My New Test Card" }
        let(:description) { "A very brief description..." }

        before do
          Troo::ListRetrieval.stubs(:retrieve).returns(@list)
        end

        subject { capture_io { described_class.new.card(list_id, card_name, description) }.join }

        context "when the list was found" do
          context "when the name was not provided" do
            let(:card_name) { }

            before { $stdin.stubs(:gets).returns(@card.name) }

            it "prompts the user" do
              subject.must_match /enter a name/
            end
          end

          context "when the card was created" do
            it "returns a polite message" do
              subject.must_match /New card '#{@card.name}' created/
            end
          end

          context "when the card was not created" do
            before { Troo::CreateCard.stubs(:for).returns(false) }

            it "returns a polite message" do
              subject.must_match /Card could not be created/
            end
          end
        end

        context "when the list was not found" do
          before { Troo::ListRetrieval.stubs(:retrieve).returns(nil) }

          it "returns a polite message" do
            subject.must_match /list was not found/
          end
        end
      end

      describe "#comment" do
        let(:card_id) { "526d8f19ddb279532e005259" }
        let(:comment) { "A very brief description..." }

        before do
          Troo::CardRetrieval.stubs(:retrieve).returns(@card)
        end

        subject { capture_io { described_class.new.comment(card_id, comment) }.join }

        context "when the card was found" do
          context "when the name was not provided" do
            let(:comment) { }

            before { $stdin.stubs(:gets).returns(@comment.text) }

            it "prompts the user" do
              subject.must_match /enter a comment/
            end
          end

          context "when the comment was created" do
            it "returns a polite message" do
              subject.must_match /New comment created/
            end
          end

          context "when the comment was not created" do
            before { Troo::CreateComment.stubs(:for).returns(false) }

            it "returns a polite message" do
              subject.must_match /Comment could not be created/
            end
          end
        end

        context "when the card was not found" do
          before { Troo::CardRetrieval.stubs(:retrieve).returns(nil) }

          it "returns a polite message" do
            subject.must_match /card was not found/
          end
        end
      end

      describe "#list" do
        let(:board_id)  { "526d8e130a14a9d846001d96" }
        let(:list_name) { "My New List" }

        before do
          Troo::BoardRetrieval.stubs(:retrieve).returns(@board)
        end

        subject { capture_io { described_class.new.list(board_id, list_name) }.join }

        context "when the board was found" do
          context "when the name was not provided" do
            let(:list_name) { }

            before { $stdin.stubs(:gets).returns(@list.name) }

            it "prompts the user" do
              subject.must_match /enter a name/
            end
          end

          context "when the list was created" do
            it "returns a polite message" do
              subject.must_match /New list '#{@list.name}' created/
            end
          end

          context "when the list was not created" do
            before { Troo::CreateList.stubs(:for).returns(false) }

            it "returns a polite message" do
              subject.must_match /List could not be created/
            end
          end
        end

        context "when the board was not found" do
          before { Troo::BoardRetrieval.stubs(:retrieve).returns(nil) }

          it "returns a polite message" do
            subject.must_match /board was not found/
          end
        end
      end
    end
  end
end
