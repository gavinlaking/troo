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

      Troo::CardPersistence.stubs(:for).returns(@card)
    end

    after { database_cleanup }

    describe ".initialize" do
      subject { described_class.new(@list, card_name, description) }

      it "assigns the list to an instance variable" do
        subject.instance_variable_get("@list").must_equal(@list)
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

      subject { described_class.for(@list, card_name, description) }

      context "when the card was created" do
        it "returns the new card" do
          subject.must_equal(@card)
        end
      end

      context "when the card was not created" do
        before { Trello::Card.stubs(:create).raises(Trello::Error) }

        it "returns false" do
          subject.must_equal false
        end
      end
    end
  end
end
