require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Show do
      let(:described_class) { Show }
      let(:board_id)        { "526d8e130a14a9d846001d96" }
      let(:list_id)         { "526d8e130a14a9d846001d97" }
      let(:card_id)         { "526d8f19ddb279532e005259" }

      before do
        @board   = Fabricate(:board)
        @board_2 = Fabricate(:board, name: "My Other Board")
        @list    = Fabricate(:list)
        @card    = Fabricate(:card)
        @comment = Fabricate(:comment)
        @member  = Fabricate(:member)
      end

      after { database_cleanup }

      describe "#boards" do
        subject { capture_io { described_class.new.boards }.join }

        context "when boards exist" do
          it "returns a list of boards" do
            subject.must_match /Test Board/
            subject.must_match /Other Board/
          end
        end

        context "when no boards exist" do
          before do
            Troo::BoardRetrieval.stubs(:all).returns([])
          end

          it "returns a polite message" do
            subject.must_match /Boards not found./
          end
        end
      end

      describe "#board" do
        subject { capture_io { described_class.new.board(board_id) }.join }

        context "when a board_id was provided" do
          context "and the board exists" do
            it "returns the board with all lists and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end
          end

          context "and the board does not exist" do
            before do
              Troo::BoardRetrieval.stubs(:retrieve).returns()
            end

            it "returns a polite message" do
              subject.must_match /Board not found./
            end
          end
        end

        context "when a board_id was not provided" do
          let(:board_id) { }

          context "and the default board is set" do
            before { Troo::BoardRetrieval.stubs(:retrieve).returns(@board) }

            it "returns the board with all lists and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end
          end

          context "and the default board is not set" do
            before { Troo::BoardRetrieval.stubs(:retrieve).returns() }

            it "returns a polite message" do
              subject.must_match /set a default board first/
            end
          end
        end
      end

      describe "#list" do
        subject { capture_io { described_class.new.list(list_id) }.join }

        context "when a list_id was provided" do
          context "when the list exists" do
            it "returns the list's board, the list and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end
          end

          context "when the list does not exist" do
            before do
              Troo::ListRetrieval.stubs(:retrieve).returns()
            end

            it "returns a polite message" do
              subject.must_match /List not found./
            end
          end
        end

        context "when a list_id was not provided" do
          let(:list_id) { }

          context "and the default list is set" do
            before { Troo::ListRetrieval.stubs(:retrieve).returns(@list) }

            it "returns the list's board, the list and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end
          end

          context "and the default list is not set" do
            before { Troo::ListRetrieval.stubs(:retrieve).returns() }

            it "returns a polite message" do
              subject.must_match /set a default list first/
            end
          end
        end
      end

      describe "#card" do
        subject { capture_io { described_class.new.card(card_id) }.join }

        context "when a card_id was provided" do
          context "when the card exists" do
            before do
              @comment.delete
            end

            it "returns the card details" do
              subject.must_match /\(67\) My Test Card/
              subject.must_match /some description/
              subject.must_match /Metadata/
              subject.must_match /Tue, Dec 17 at 21:48/
            end
          end

          context "when the card does not exist" do
            before do
              Troo::CardRetrieval.stubs(:retrieve).returns()
            end

            it "returns a polite message" do
              subject.must_match /Card not found./
            end
          end
        end

        context "when a card_id was not provided" do
          let(:card_id) { }

          context "and the default card is set" do
            before { Troo::CardRetrieval.stubs(:retrieve).returns(@card) }

            it "returns the card details" do
              subject.must_match /\(67\) My Test Card/
              subject.must_match /some description/
              subject.must_match /Metadata/
              subject.must_match /Tue, Dec 17 at 21:48/
            end
          end

          context "and the default card is not set" do
            before { Troo::CardRetrieval.stubs(:retrieve).returns() }

            it "returns a polite message" do
              subject.must_match /set a default card first/
            end
          end
        end
      end

      describe "#comments" do
        subject { capture_io { described_class.new.comments(card_id) }.join }

        context "when a card_id was provided" do
          context "when the card exists" do
            it "returns the card and all comments" do
              subject.must_match /\(67\) My Test Card/
              subject.must_match /My Test Comment/
            end
          end

          context "when the card does not exist" do
            before do
              Troo::CardRetrieval.stubs(:retrieve).returns()
            end

            it "returns a polite message" do
              subject.must_match /Card not found./
            end
          end
        end

        context "when a card_id was not provided" do
          let(:card_id) { }

          context "and the default card is set" do
            before { Troo::CardRetrieval.stubs(:retrieve).returns(@card) }

            it "returns the card and all comments" do
              subject.must_match /\(67\) My Test Card/
              subject.must_match /My Test Comment/
            end
          end

          context "and the default card is not set" do
            before { Troo::CardRetrieval.stubs(:retrieve).returns() }

            it "returns a polite message" do
              subject.must_match /set a default card first/
            end
          end
        end
      end
    end
  end
end
