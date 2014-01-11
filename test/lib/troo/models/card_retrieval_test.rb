require_relative "../../../test_helper"

module Troo
  describe CardRetrieval do
    let(:described_class) { CardRetrieval }
    let(:default) { true }
    let(:card_name) { "My Test Card" }

    before { @card = Fabricate(:card, default: default, name: card_name) }
    after  { database_cleanup }

    describe ".all" do
      subject { described_class.all }

      it "retrieves all locally stored cards" do
        subject.size.must_equal 1
      end
    end

    describe ".default" do
      subject { described_class.default }

      context "when default is set" do
        it "returns the default" do
          subject.must_equal @card
        end
      end

      context "when default is not set" do
        let(:default) { false }

        it { subject.must_equal(nil) }
      end
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        context "when default is set" do
          it "returns the default" do
            subject.must_equal @card
          end
        end

        context "when default is not set" do
          let(:default) { false }

          it { subject.must_equal(nil) }
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

          before { ExternalCard.stubs(:fetch).returns([@card]) }

          it "returns the correct card" do
            subject.name.must_equal("My Remote Test Card")
          end
        end

        context "when the ID cannot be found" do
          let(:id) { "not_found_id" }

          before { ExternalCard.stubs(:fetch).returns([]) }

          it { subject.must_equal(nil) }
        end
      end
    end
  end
end
