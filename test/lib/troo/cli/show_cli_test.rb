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
          before { BoardRetrieval.stubs(:all).returns([]) }

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

            context "but there are no lists" do
              before { @list.delete }

              it "returns a polite message" do
                subject.must_match /No lists were found/
              end
            end
          end

          context "and the board does not exist" do
            before { BoardRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /Board cannot be found./
            end
          end
        end

        context "when a board_id was not provided" do
          let(:board_id) { }

          context "and the default board is set" do
            before { BoardRetrieval.stubs(:retrieve).returns(@board) }

            it "returns the board with all lists and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end
          end

          context "and the default board is not set" do
            before { BoardRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /set a default board first/
            end
          end
        end
      end

      describe "#list" do
        subject { capture_io { described_class.new.list(list_id) }.join }

        context "when a list_id was provided" do
          context "and the list exists" do
            it "returns the list's board, the list and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end

            context "but there are no cards" do
              before { @card.delete }

              it "returns a polite message" do
                subject.must_match /No cards were found/
              end
            end
          end

          context "and the list does not exist" do
            before { ListRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /List cannot be found/
            end
          end
        end

        context "when a list_id was not provided" do
          let(:list_id) { }

          context "and the default list is set" do
            before { ListRetrieval.stubs(:retrieve).returns(@list) }

            it "returns the list's board, the list and all cards" do
              subject.must_match /Test Board/
              subject.must_match /Test List/
              subject.must_match /Test Card/
            end
          end

          context "and the default list is not set" do
            before { ListRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /set a default list first/
            end
          end
        end
      end

      describe "#card" do
        subject { capture_io { described_class.new.card(card_id) }.join }

        context "when a card_id was provided" do
          context "and the card exists" do
            it "returns the card details" do
              subject.must_match /\(67\) My Test Card/
              subject.must_match /some description/
              subject.must_match /Metadata/
              subject.must_match /Tue, Dec 17 at 21:48/
            end

            context "but there are no comments" do
              before { @comment.delete }

              it "returns a polite message" do
                subject.must_match /No comments have been left/
              end
            end
          end

          context "and the card does not exist" do
            before { CardRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /Card cannot be found/
            end
          end
        end

        context "when a card_id was not provided" do
          let(:card_id) { }

          context "and the default card is set" do
            before { CardRetrieval.stubs(:retrieve).returns(@card) }

            it "returns the card details" do
              subject.must_match /\(67\) My Test Card/
              subject.must_match /some description/
              subject.must_match /Metadata/
              subject.must_match /Tue, Dec 17 at 21:48/
            end
          end

          context "and the default card is not set" do
            before { CardRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /set a default card first/
            end
          end
        end
      end

      describe "#comments" do
        subject { capture_io { described_class.new.comments(card_id) }.join }

        context "when a card_id was provided" do
          context "and the card exists" do
            it "returns the card and all comments" do
              subject.must_match /My Test Card/
              subject.must_match /My Test Comment/
            end

            context "but there are no comments" do
              before { @comment.delete }

              it "returns a polite message" do
                subject.must_match /No comments were found/
              end
            end
          end

          context "and the card does not exist" do
            before { CardRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /Card cannot be found/
            end
          end
        end

        context "when a card_id was not provided" do
          let(:card_id) { }

          context "and the default card is set" do
            before { CardRetrieval.stubs(:retrieve).returns(@card) }

            it "returns the card and all comments" do
              subject.must_match /My Test Card/
              subject.must_match /My Test Comment/
            end
          end

          context "and the default card is not set" do
            before { CardRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /set a default card first/
            end
          end
        end
      end
    end
  end
end
