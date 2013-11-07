require_relative "../../../test_helper"

module Trlo
  describe Card do
    describe ".all" do
      subject { Card.all(list_id) }

      it "gets all the cards for the specified list_id" do
        skip("Please write spec.")
      end
    end

    describe ".find" do
      subject { Card.find(card_id) }

      it "gets the card by card_id" do
        skip("Please write spec.")
      end
    end
  end

  describe Card do
    let(:card) { OpenStruct.new(id:   "some_24bit_string",
                                short_id: "212",
                                name: "Finish Trlo") }

    describe "#short_id" do
      it "returns the Trello short ID of the card" do
        Card.new(card).short_id.must_equal "212"
      end
    end

    describe "#id" do
      it "returns the Trello ID of the card" do
        Card.new(card).id.must_equal "some_24bit_string"
      end
    end

    describe "#name" do
      it "returns the name of the list" do
        Card.new(card).name.must_equal "Finish Trlo"
      end
    end

    describe "#decorate" do
      it "returns a hash containing data from the card" do
        Card.new(card).
          decorate.must_equal({ id:       "some_24bit_string",
                                short_id: "212",
                                name:     "Finish Trlo",
                                header:   { short_id: "ID", name: "Name" } })
      end
    end
  end
end
