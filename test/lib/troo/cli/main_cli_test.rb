require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }
      let(:described_instance) { described_class.new }

      before { @board = Fabricate(:board) }
      after  { database_cleanup }

      describe "#status" do
        let(:default) { false }

        before do
          @board = Fabricate(:board, default: default)
          @list  = Fabricate(:list, default: default)
          @card  = Fabricate(:card, default: default)
        end

        subject { capture_io { described_instance.status }.join }

        context "when a default board is set" do
          let(:default) { true }

          it "returns a polite message" do
            subject.must_match /My Test Board/
          end
        end

        context "when a default board is not set" do
          it "returns a polite message" do
            subject.must_match /No default board set/
          end
        end

        context "when a default list is set" do
          let(:default) { true }

          it "returns a polite message" do
            subject.must_match /My Test List/
          end
        end

        context "when a default list is not set" do
          it "returns a polite message" do
            subject.must_match /No default list set/
          end
        end

        context "when a default card is set" do
          let(:default) { true }

          it "returns a polite message" do
            subject.must_match /My Test Card/
          end
        end

        context "when a default card is not set" do
          it "returns a polite message" do
            subject.must_match /No default card set/
          end
        end

        context "when there are no boards" do
          before { Troo::Board.stubs(:count).returns(0) }

          it "returns a polite message" do
            subject.must_match /No boards found/
          end
        end

        context "when there are no lists" do
          before { Troo::List.stubs(:count).returns(0) }

          it "returns a polite message" do
            subject.must_match /No lists found/
          end
        end

        context "when there are no cards" do
          before { Troo::Card.stubs(:count).returns(0) }

          it "returns a polite message" do
            subject.must_match /No cards found/
          end
        end
      end

      describe "#refresh" do
        let(:default) { @board }

        subject { capture_io { described_instance.refresh }.join }

        before do
          RefreshAll.stubs(:all)
          RefreshAll.stubs(:default)
          BoardRetrieval.stubs(:default).returns(default)
          RefreshAll.stubs(:lists)
          RefreshAll.stubs(:cards)
        end

        context "when the --all option is set" do
          before { described_instance.stubs(:options).returns({"all" => true}) }

          it "refreshes all local data" do
            subject.must_match /All local data has been refreshed./
          end
        end

        context "when the default board is set" do
          context "when the --lists option is set" do
            before { described_instance.stubs(:options).returns({"lists" => true}) }

            it "refresh all the lists for the default board" do
              subject.must_match /lists for the default board have been refreshed/
            end
          end

          context "when the --cards option is set" do
            before { described_instance.stubs(:options).returns({"cards" => true}) }

            it "retreshes all the cards for the default board" do
              subject.must_match /cards for the default board have been refreshed/
            end
          end

          context "when no additional options are set" do
            it "refreshes all local data" do
              subject.must_match /All data for the default board has been refreshed./
            end
          end
        end

        context "when the default board is not set" do
          let(:default) { }

          it "returns a polite message" do
            subject.must_match /to set a default board first/
          end
        end

        context "when the Trello access token credentials are invalid" do
          before do
            described_instance.stubs(:options).returns({"all" => true})
            Troo::RefreshAll.stubs(:all).raises(Troo::InvalidAccessToken)
          end

          it "returns a polite message" do
            subject.must_match /access credentials have expired, please renew/
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
          CardRetrieval.stubs(:retrieve).returns(@card)
          ListRetrieval.stubs(:retrieve).returns(@list)
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
            before { ListRetrieval.stubs(:retrieve) }

            it "returns a polite message" do
              subject.must_match /list was not found/
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
    end
  end
end
