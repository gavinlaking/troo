require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Card do
      let(:described_class) { Card }
      let(:card_id) { "526d8f19ddb279532e005259" }

      before do
        @board = Fabricate(:board)
        @list  = Fabricate(:list)
        @card  = Fabricate(:card)
      end

      after do
        database_cleanup
      end

      describe "#show" do
        subject { capture_io { described_class.new.show(card_id) }.join }

        context "when the card exists" do
          it "returns the card details" do
            subject.must_match /\(67\) My Test Card/
            subject.must_match /some description/
            subject.must_match /No comments have been left./
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
    end
  end
end
