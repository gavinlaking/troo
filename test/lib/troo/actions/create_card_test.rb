require_relative "../../../test_helper"

module Troo
  describe CreateCard do
    let(:described_class) { CreateCard }
    let(:list_id)  { "526d8e130a14a9d846001d97" }
    let(:card_name) { "My New Card" }
    let(:description) { "A description to get us started." }

    before do
      @list = Fabricate(:list)
      @card = Fabricate(:card, name: card_name, desc: description)

      Troo::ListRetrieval.stubs(:retrieve).returns(@list)
      Troo::CardPersistence.stubs(:for).returns(@card)
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(list_id, card_name, description) }

      it "assigns the list_id to an instance variable" do
        subject.instance_variable_get("@list_id").must_equal(list_id)
      end

      it "assigns the name to an instance variable" do
        subject.instance_variable_get("@name").must_equal(card_name)
      end

      it "assigns the description to an instance variable" do
        subject.instance_variable_get("@description").must_equal(description)
      end
    end

    describe ".for" do
      before { VCR.insert_cassette(:create_card, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.for(list_id, card_name, description) }

      context "when the card was created" do
        it "returns the new card" do
          subject.must_equal(@card)
        end
      end

      context "when the card was not created" do
        before do
          Trello::Card.stubs(:create).raises(Trello::Error)
        end

        it "returns nil" do
          subject.must_equal false
        end
      end
    end
  end
end
