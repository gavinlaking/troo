require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Card do
      let(:described_class) { Card }

      describe "#all" do
        let(:board_id) { "526d8e130a14a9d846001d96" }

        subject { described_class.new.all(board_id) }

        context "when there are cards" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end

        context "when there are no cards" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end
      end

      describe "#show" do
        let(:card_id) { "526d8f19ddb279532e005259" }

        subject { described_class.new.show(card_id) }

        context "when the card exists" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end

        context "when the card does not exist" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end
      end
    end
  end
end
