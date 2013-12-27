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

      describe "#refresh" do
        let(:current) { @board }

        subject { capture_io { described_instance.refresh }.join }

        before do
          RefreshAll.stubs(:perform)
          Troo::BoardRetrieval.stubs(:current).returns(current)
          RefreshAll.stubs(:lists)
          RefreshAll.stubs(:cards)
        end

        context "when no additional options are set" do
          it "refreshes all local data" do
            subject.must_match /All local data has been refreshed./
          end
        end

        context "when the --lists option is set" do
          before do
            described_instance.stubs(:options).returns({"lists" => true})
          end

          context "when a current board is set" do
            it "refresh all the lists for the current board" do
              subject.must_match /lists for current board have been refreshed/
            end
          end

          context "when a current board is not set" do
            let(:current) { }

            it "returns a polite message" do
              subject.must_match /to set a current board first/
            end
          end
        end

        context "when the --cards option is set" do
          before do
            described_instance.stubs(:options).returns({"cards" => true})
          end

          context "when a current board is set" do
            it "retreshes all the cards for the current board" do
              subject.must_match /cards for current board have been refreshed/
            end
          end

          context "when a current board is not set" do
            let(:current) { }

            it "returns a polite message" do
              subject.must_match /to set a current board first/
            end
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
        let(:move_card) { OpenStruct.new(external_card_id: card_id,
                                         source_list_id: @card.external_list_id,
                                         source_list_name: @card.list.name,
                                         destination_list_id: list_id,
                                         destination_list_name: @destination_list.name) }

        before do
          @card = Fabricate(:card)
          @list = Fabricate(:list)
          @destination_list = Fabricate(:list, name: "My New List", external_list_id: list_id)
          Troo::ExternalCard.stubs(:fetch).returns(@card)
          Troo::MoveCard.stubs(:with).returns(move_card)
        end

        subject { capture_io { described_class.new.move(card_id, list_id) }.join }

        it "moves the card and returns a polite message" do
          subject.must_match /Card moved from/
        end
      end
    end
  end
end
