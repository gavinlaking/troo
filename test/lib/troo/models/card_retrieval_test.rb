require_relative "../../../test_helper"

module Troo
  describe CardRetrieval do
    let(:described_class) { CardRetrieval }

    before do
      Ohm.redis.flushdb
    end

    describe ".current" do
      subject { described_class.current }

      before do
        @current = Troo::Card.create(current: current)
      end

      after do
        @current.delete
      end

      context "when current is set" do
        let(:current) { true }

        it "returns the current" do
          subject.must_equal @current
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
      before do
        @card = Troo::Card.create({
                  name:             "My Test Card",
                  short_id:         17,
                  external_card_id: "526d8f19ddb279532e005259" })
      end

      after do
        @card.delete
      end

      context "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored cards" do
          subject.size.must_equal 1
        end
      end

      context "with an ID" do
        subject { described_class.retrieve(id) }

        context "local retrieval by database ID" do
          let(:id) { @card.id }

          it "returns the correct card" do
            subject.name.must_equal("My Test Card")
          end
        end

        context "local retrieval by short_id" do
          let(:id) { 17 }

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
          before do
            @card.delete
            ExternalCard.stubs(:fetch).returns(remote_card)
          end

          let(:id) { "526d_remote_card_005259" }
          let(:remote_card) { [Troo::Card.new({
                                 name:             "My Remote Test Card",
                                 short_id:         66,
                                 external_card_id: id })] }

          it "returns the correct card" do
            subject.name.must_equal("My Remote Test Card")
          end
        end
      end
    end
  end
end
