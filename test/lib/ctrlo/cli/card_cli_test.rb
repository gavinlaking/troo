require_relative "../../../test_helper"
require "thor"

module Ctrlo
  module CLI
    describe Card do
      let(:described_class) { Card }

      describe "#all" do
        subject { described_class }

        it "" do
          skip
        end
      end

      describe "#current" do
        let(:card_id) { "some_card_id" }

        subject { described_class.new.current(card_id) }

        describe "when the card_id cannot be found" do
          before do
            Ctrlo::CardRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            proc { subject }.must_output("Card cannot be found.\n")
          end
        end

        describe "when the card_id was found" do
          let(:card) { Ctrlo::Card.new(name: "My Card", current: false) }

          before do
            Ctrlo::CardRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(card)
          end

          it "reports success" do
            proc { subject }.must_output("Card 'My Card' set to current.\n")
          end
        end
      end

      describe "#show" do
        subject { described_class }

        it "" do
          skip
        end
      end

      describe "#comment" do
        subject { described_class }

        it "" do
          skip
        end
      end

      describe "#move" do
        subject { described_class }

        it "" do
          skip
        end
      end
    end
  end
end
