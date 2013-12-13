require_relative "../../../test_helper"

module Troo
  describe CardRetrieval do
    let(:described_class) { CardRetrieval }

    describe ".current" do
      subject { described_class.current }

      before do
        Troo::Card.stubs(:first).returns(current_card)
      end

      describe "when current is set" do
        let(:current_card) { Troo::Card.new(current: true) }

        it "returns the current card" do
          subject.must_equal current_card
        end
      end

      describe "when current is not set" do
        let(:current_card) { nil }

        it "returns nil" do
          subject.must_equal current_card
        end
      end
    end

    describe ".retrieve" do
      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored cards" do
          skip
        end
      end

      describe "with an ID" do
        subject { described_class.retrieve(id) }

        let(:id) { }

        describe "local retrieval by database ID" do
          it "" do
            skip
          end
        end

        describe "local retrieval by external ID" do
          it "" do
            skip
          end
        end

        describe "remote retrieval by either ID" do
          it "" do
            skip
          end
        end
      end
    end
  end
end
