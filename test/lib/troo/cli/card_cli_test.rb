require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Card do
      let(:described_class) { Card }

      before do
      end

      after do
        database_cleanup
      end

      describe "#show" do
        let(:card_id) { "526d8f19ddb279532e005259" }

        subject { capture_io { described_class.new.show(card_id) }.join }

        context "when the card exists" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end

        context "when the card does not exist" do
          it "returns a polite message" do
            subject.must_match /Not implemented yet./
          end
        end
      end
    end
  end
end
