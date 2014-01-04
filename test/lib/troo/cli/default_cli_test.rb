require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Default do
      let(:described_class) { Default }
      let(:board_id) { "526d8e130a14a9d846001d96" }
      let(:card_id) { "526d8f19ddb279532e005259" }
      let(:list_id) { "526d8e130a14a9d846001d97" }

      before do
        @board = Fabricate(:board)
        @list  = Fabricate(:list)
        @card  = Fabricate(:card)

        Troo::BoardRetrieval.stubs(:retrieve).returns(@board)
        Troo::CardRetrieval.stubs(:retrieve).returns(@card)
        Troo::ListRetrieval.stubs(:retrieve).returns(@list)
      end

      after do
        database_cleanup
      end

      describe "#board" do
        subject { capture_io { described_class.new.board(board_id) }.join }

        context "when the board_id cannot be found" do
          before do
            Troo::BoardRetrieval.stubs(:retrieve).returns(nil)
          end

          it "returns a polite message" do
            subject.must_match /Board cannot be found/
          end
        end

        context "when the board_id was found" do
          it "returns a polite message" do
            subject.must_match /Board '#{@board.name}' set to default/
          end
        end
      end

      describe "#card" do
        subject { capture_io { described_class.new.card(card_id) }.join }

        context "when the card_id cannot be found" do
          before do
            Troo::CardRetrieval.stubs(:retrieve).returns(nil)
          end

          it "returns a polite message" do
            subject.must_match /Card cannot be found/
          end
        end

        context "when the card_id was found" do
          it "returns a polite message" do
            subject.must_match /Card '#{@card.name}' set to default/
          end
        end
      end

      describe "#list" do
        subject { capture_io { described_class.new.list(list_id) }.join }

        context "when the list_id cannot be found" do
          before do
            Troo::ListRetrieval.stubs(:retrieve).returns(nil)
          end

          it "returns a polite message" do
            subject.must_match /List cannot be found/
          end
        end

        context "when the list_id was found" do
          it "returns a polite message" do
            subject.must_match /List '#{@list.name}' set to default/
          end
        end
      end
    end
  end
end
