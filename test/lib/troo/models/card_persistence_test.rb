require_relative "../../../test_helper"

module Troo
  describe CardPersistence do
    let(:described_class) { CardPersistence }

    before do
      database_cleanup
      @card = Troo::Card.create({
        name:             "My Test Card",
        closed:           false,
        external_card_id: "526d8f19ddb279532e005259"
      })
    end

    after do
      @card.delete
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource) { OpenStruct.new({
          id:     "526d8f19ddb279532e005259",
          name:   "My Test Card",
          closed: false
        }) }

        it "returns the local copy" do
          subject.must_equal(@card)
        end
      end

      context "when the local copy is out of date" do
        let(:resource) { OpenStruct.new({
          id:     "526d8f19ddb279532e005259",
          name:   "My Renamed Card",
          closed: false
        }) }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed Card")
        end
      end

      context "when there is no local copy" do
        before do
          @card.delete
        end

        let(:resource) { OpenStruct.new({
          id:     "526d8f19ddb279532e005259",
          name:   "My New Test Card",
          closed: false
        }) }

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test Card")
        end
      end
    end
  end
end

