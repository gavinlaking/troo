require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Default do
      let(:described_class) { Default }

      describe "#board" do
        let(:id) { "526d8e130a14a9d846001d96" }

        subject { capture_io { described_class.new.board(id) }.join }

        context "when the id cannot be found" do
          before { BoardRetrieval.stubs(:retrieve) }

          it "returns a polite message" do
            subject.must_match /Board cannot be found/
          end
        end

        context "when the id was found" do
          before do
            @board = Fabricate.build(:board)
            BoardRetrieval.stubs(:retrieve).returns(@board)
          end

          it "returns a polite message" do
            subject.must_match /'#{@board.name}' set as default/
          end
        end
      end

      describe "#card" do
        let(:id) { "526d8f19ddb279532e005259" }

        before do
          @card  = Fabricate.build(:card)
          CardRetrieval.stubs(:retrieve).returns(@card)
        end

        subject { capture_io { described_class.new.card(id) }.join }

        context "when the id cannot be found" do
          before { CardRetrieval.stubs(:retrieve) }

          it "returns a polite message" do
            subject.must_match /Card cannot be found/
          end
        end

        context "when the id was found" do
          it "returns a polite message" do
            subject.must_match /'#{@card.name}' set as default/
          end
        end
      end

      describe "#list" do
        let(:id) { "526d8e130a14a9d846001d97" }

        subject { capture_io { described_class.new.list(id) }.join }

        context "when the id cannot be found" do
          before { ListRetrieval.stubs(:retrieve) }

          it "returns a polite message" do
            subject.must_match /List cannot be found/
          end
        end

        context "when the id was found" do
          before do
            @list = Fabricate.build(:list)
            ListRetrieval.stubs(:retrieve).returns(@list)
          end

          it "returns a polite message" do
            subject.must_match /'#{@list.name}' set as default/
          end
        end
      end
    end
  end
end
