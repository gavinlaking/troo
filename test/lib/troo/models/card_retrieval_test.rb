require_relative "../../../test_helper"

module Troo
  describe CardRetrieval do
    let(:described_class) { CardRetrieval }
    let(:current) { true }
    let(:card_name) { "My Test Card" }

    before do
      @card = Fabricate(:card, current: current, name: card_name)
    end

    after do
      database_cleanup
    end

    describe ".current" do
      subject { described_class.current }

      context "when current is set" do
        it "returns the current" do
          subject.must_equal @card
        end
      end

      context "when current is not set" do
        let(:current) { false }

        it "returns nil" do
          subject.must_equal nil
        end
      end
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored cards" do
          subject.size.must_equal 1
        end
      end

      context "with an ID" do
        subject { described_class.retrieve(id) }

        context "local retrieval by short_id" do
          let(:id) { 67 }

          it "returns the correct card" do
            subject.name.must_equal("My Test Card")
          end
        end

        context "local retrieval by database ID" do
          let(:id) { @card.id }

          it "returns the correct card" do
            subject.name.must_equal("My Test Card")
          end
        end

        context "local retrieval by external ID" do
          let(:id) { "526d8f19ddb279532e005259" }

          it "returns the correct card" do
            subject.name.must_equal("My Test Card")
          end
        end

        context "remote retrieval by either ID" do
          let(:id) { "526d_remote_card_005259" }
          let(:card_name) { "My Remote Test Card" }

          before do
            ExternalCard.stubs(:fetch).returns([@card])
          end

          it "returns the correct card" do
            subject.name.must_equal("My Remote Test Card")
          end
        end
      end
    end
  end
end
