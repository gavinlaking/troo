require_relative "../../../test_helper"

module Troo
  describe MoveCard do
    let(:described_class) { MoveCard }
    let(:card_id) { "526d8f19ddb279532e005259" }
    let(:list_id) { "526d8e130a14a9d846001d98" }

    before do
      @destination_list = Fabricate(:list, external_list_id: list_id)
      @list = Fabricate(:list)
      @card = Fabricate(:card)
      Troo::ListRetrieval.stubs(:retrieve).returns(@destination_list)
      Troo::CardRetrieval.stubs(:retrieve).returns(@card)
    end

    after do
      database_cleanup
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
      before { VCR.insert_cassette(:move_card) }
      after  { VCR.eject_cassette }

      subject { described_class.with(card_id, list_id) }

      it "moves the card to the new list and returns an instance of this class" do
        subject.must_be_instance_of(described_class)
      end
    end

    describe "#source_list_id" do
      subject { described_class.new(card_id, list_id).source_list_id }

      it "returns the source list id" do
        subject.must_equal(@card.external_list_id)
      end
    end

    describe "#source_list_name" do
      subject { described_class.new(card_id, list_id).source_list_name }

      it "returns the source list name" do
        subject.must_equal(@card.list.name)
      end
    end

    describe "#destination_list_id" do
      subject { described_class.new(card_id, list_id).destination_list_id }

      it "returns the destination list id" do
        subject.must_equal(@destination_list.external_list_id)
      end
    end

    describe "#destination_list_name" do
      subject { described_class.new(card_id, list_id).destination_list_name }

      it "returns the destination list name" do
        subject.must_equal(@destination_list.name)
      end
    end

    describe "#external_card_id" do
      subject { described_class.new(card_id, list_id).external_card_id }

      it "returns the external_card_id" do
        subject.must_equal(@card.external_card_id)
      end
    end
  end
end
