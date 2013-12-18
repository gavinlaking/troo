require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Add do
      let(:described_class) { Add }

      describe "#board" do
        let(:board_name) { "somename" }

        subject { capture_io { described_class.new.board(board_name) }.join }

        it "does something" do
          subject.must_match /Not implemented yet./
        end
      end

      describe "#card" do
        let(:list_id) { "526d8e130a14a9d846001d97" }
        let(:card_name) { "somename" }

        subject { capture_io { described_class.new.card(list_id, card_name) }.join }

        context "when the name is provided" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end

        context "when the name is not provided" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end
      end

      describe "#list" do
        let(:board_id) { "526d8e130a14a9d846001d96" }
        let(:list_name) { "somename" }

        subject { capture_io { described_class.new.list(board_id, list_name) }.join }

        context "when the name is provided" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end

        context "when the name is not provided" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end
      end
    end
  end
end
