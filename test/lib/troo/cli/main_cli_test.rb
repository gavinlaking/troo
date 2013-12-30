require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }
      let(:described_instance) { described_class.new }

      before do
        @board = Fabricate(:board)
      end

      after do
        database_cleanup
      end

      describe "#status" do
        before do
          @board = Fabricate(:board, current: true)
          @list  = Fabricate(:list, current: true)
          @card  = Fabricate(:card, current: true)
        end

        subject { capture_io { described_instance.status }.join }

        context "when a current board is set" do
          it "returns a polite message" do
            subject.must_match /My Test Board/
          end
        end

        context "when a current board is not set" do
          before { Troo::BoardRetrieval.stubs(:current).returns(nil) }

          it "returns a polite message" do
            subject.must_match /No board/
          end
        end

        context "when a current list is set" do
          it "returns a polite message" do
            subject.must_match /My Test List/
          end
        end

        context "when a current list is not set" do
          before { Troo::ListRetrieval.stubs(:current).returns(nil) }

          it "returns a polite message" do
            subject.must_match /No list/
          end
        end

        context "when a current card is set" do
          it "returns a polite message" do
            subject.must_match /My Test Card/
          end
        end

        context "when a current card is not set" do
          before { Troo::CardRetrieval.stubs(:current).returns(nil) }

          it "returns a polite message" do
            subject.must_match /No card/
          end
        end
      end

      describe "#refresh" do
        let(:current) { @board }

        subject { capture_io { described_instance.refresh }.join }

        before do
          RefreshAll.stubs(:all)
          RefreshAll.stubs(:current)
          Troo::BoardRetrieval.stubs(:current).returns(current)
          RefreshAll.stubs(:lists)
          RefreshAll.stubs(:cards)
        end

        context "when the --all option is set" do
          before do
            described_instance.stubs(:options).returns({"all" => true})
          end

          it "refreshes all local data" do
            subject.must_match /All local data has been refreshed./
          end
        end

        context "when the current board is set" do
          context "when the --lists option is set" do
            before do
              described_instance.stubs(:options).returns({"lists" => true})
            end

            it "refresh all the lists for the current board" do
              subject.must_match /lists for the current board have been refreshed/
            end
          end

          context "when the --cards option is set" do
            before do
              described_instance.stubs(:options).returns({"cards" => true})
            end

            it "retreshes all the cards for the current board" do
              subject.must_match /cards for the current board have been refreshed/
            end
          end

          context "when no additional options are set" do
            it "refreshes all local data" do
              subject.must_match /All data for the current board has been refreshed./
            end
          end
        end

        context "when the current board is not set" do
          let(:current) { }

          it "returns a polite message" do
            subject.must_match /to set a current board first/
          end
        end
      end

      describe "#cleanup" do
        subject { capture_io { described_class.new.cleanup }.join }

        context "when the user confirms their intentions" do
          before { $stdin.stubs(:gets).returns("y\n") }

          it "removes all local data" do
             subject.must_match /All local data has been removed./
          end
        end

        context "when the user denies their intentions" do
          before { $stdin.stubs(:gets).returns("n\n") }

          it "does not remove the local data" do
            subject.must_match("")
          end
        end
      end

      describe "#version" do
        subject { capture_io { described_class.new.version }.join }

        it "prints the version" do
          subject.must_match /troo #{Troo::VERSION}/
        end
      end

      describe "#move" do
        let(:card_id)   { "526d8f19ddb279532e005259" }
        let(:list_id)   { "526d8e130a14a9d846001d98" }

        before do
          @card = Fabricate(:card)
          @list = Fabricate(:list)
          Troo::MoveCard.stubs(:with).returns(true)
          Troo::CardRetrieval.stubs(:retrieve).returns(@card)
          Troo::ListRetrieval.stubs(:retrieve).returns(@list)
        end

        subject { capture_io { described_class.new.move(card_id, list_id) }.join }

        context "when the card was found" do
          context "when the list was found" do
            context "when the card could be moved" do
              it "returns a polite message" do
                subject.must_match /Card moved from/
              end
            end

            context "when the card could not be moved" do
              before { Troo::MoveCard.stubs(:with).returns(false) }

              it "returns a polite message" do
                subject.must_match /could not be moved/
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

        context "when the card was not found" do
          before { Troo::CardRetrieval.stubs(:retrieve).returns(nil) }

          it "returns a polite message" do
            subject.must_match /card was not found/
          end
        end
      end
    end
  end
end
