require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Add do
      let(:described_class) { Add }

      before do
        @board   = Fabricate.build(:board, name: "My New Test Board")
        @card    = Fabricate.build(:card, name: "My New Test Card")
        @comment = Fabricate.build(:comment)
        @list    = Fabricate.build(:list, name: "My New Test List")

        CreateBoard.stubs(:with).returns(@board)
        CreateCard.stubs(:for).returns(@card)
        CreateComment.stubs(:for).returns(@comment)
        CreateList.stubs(:for).returns(@list)
      end

      after { database_cleanup }

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
          before { CreateBoard.stubs(:with).returns(false) }

          it "returns a polite message" do
            subject.must_match /Board could not be created/
          end
        end

        context "when the Trello access token credentials are invalid" do
          before { CreateBoard.stubs(:with).raises(Troo::InvalidAccessToken) }

          it "returns a polite message" do
            subject.must_match /access credentials have expired, please renew/
          end
        end
      end

      describe "#card" do
        let(:list_id)     { "526d8e130a14a9d846001d97" }
        let(:card_name)   { "My New Test Card" }
        let(:description) { "A very brief description..." }

        before { ListRetrieval.stubs(:retrieve).returns(@list) }

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
            before { CreateCard.stubs(:for).returns(false) }

            it "returns a polite message" do
              subject.must_match /Card could not be created/
            end
          end

          context "when the Trello access token credentials are invalid" do
            before { CreateCard.stubs(:for).raises(Troo::InvalidAccessToken) }

            it "returns a polite message" do
              subject.must_match /access credentials have expired, please renew/
            end
          end
        end

        context "when the list was not found" do
          before { ListRetrieval.stubs(:retrieve) }

          it "returns a polite message" do
            subject.must_match /list was not found/
          end
        end
      end

      describe "#comment" do
        let(:card_id) { "526d8f19ddb279532e005259" }
        let(:comment) { "A very brief description..." }

        before { CardRetrieval.stubs(:retrieve).returns(@card) }

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
            before { CreateComment.stubs(:for).returns(false) }

            it "returns a polite message" do
              subject.must_match /Comment could not be created/
            end
          end

          context "when the Trello access token credentials are invalid" do
            before { CreateComment.stubs(:for).raises(Troo::InvalidAccessToken) }

            it "returns a polite message" do
              subject.must_match /access credentials have expired, please renew/
            end
          end
        end

        context "when the card was not found" do
          before { CardRetrieval.stubs(:retrieve) }

          it "returns a polite message" do
            subject.must_match /card was not found/
          end
        end
      end

      describe "#list" do
        let(:board_id)  { "526d8e130a14a9d846001d96" }
        let(:list_name) { "My New List" }

        before { BoardRetrieval.stubs(:retrieve).returns(@board) }

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
            before { CreateList.stubs(:for).returns(false) }

            it "returns a polite message" do
              subject.must_match /List could not be created/
            end
          end

          context "when the Trello access token credentials are invalid" do
            before { CreateList.stubs(:for).raises(Troo::InvalidAccessToken) }

            it "returns a polite message" do
              subject.must_match /access credentials have expired, please renew/
            end
        end
        end

        context "when the board was not found" do
          before { BoardRetrieval.stubs(:retrieve) }

          it "returns a polite message" do
            subject.must_match /board was not found/
          end
        end
      end
    end
  end
end
