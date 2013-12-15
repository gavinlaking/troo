require_relative "../../../test_helper"

module Troo
  describe MoveCard do
    let(:described_class) { MoveCard }
    let(:card_id) { "526d8f19ddb279532e005259" }
    let(:list_id) { "526d8e130a14a9d846001d97" }

    before do
      @destination_list = Troo::List.create(external_list_id: list_id)
      @card = Troo::Card.create(external_card_id: card_id, external_list_id: list_id)
    end

    after do
      @destination_list.delete
      @card.delete
    end

    describe ".initialize" do
      subject { described_class.new(card_id, list_id) }

      it "assigns the card_id" do
        subject.instance_variable_get("@card_id").must_equal(card_id)
      end

      it "assigns the list_id" do
        subject.instance_variable_get("@list_id").must_equal(list_id)
      end
    end

    describe "#move" do
      subject { described_class.with(card_id, list_id) }

      it "" do
        skip
      end
    end

    describe "#source_list_id" do
      subject { described_class.new(card_id, list_id).source_list_id }

      it "" do
        skip
      end
    end

    describe "#destination_list_id" do
      subject { described_class.new(card_id, list_id).destination_list_id }

      it "" do
        skip
      end
    end
  end
end
