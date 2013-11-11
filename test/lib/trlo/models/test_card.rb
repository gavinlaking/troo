require_relative "../../../test_helper"

module Trlo
  describe Card do
    let(:card) { OpenStruct.new(id:       "some_24bit_card_id",
                                short_id: "212",
                                name:     "Finish Trlo") }

    describe "#short_id" do
      it "returns the Trello short ID of the card" do
        Card.new(card).short_id.must_equal "212"
      end
    end

    describe "#id" do
      it "returns the Trello ID of the card" do
        Card.new(card).id.must_equal "some_24bit_card_id"
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
          decorate.must_equal({ id:       "some_24bit_card_id",
                                short_id: "212",
                                name:     "Finish Trlo",
                                header:   { short_id: "ID", name: "Name" } })
      end
    end
  end

  describe FindCard do
    describe ".with" do
      let(:card_id) { "some_24bit_card_id" }
      let(:card) { OpenStruct.new(id:       "some_24bit_card_id",
                                  short_id: "212",
                                  name:     "Finish Trlo") }
      subject { FindCard.with(card_id) }

      before do
        Trello::Card.stubs(:find).returns(card)
      end

      it "finds the card by card_id" do
        subject.must_equal card
      end
    end
  end

  describe FindCards do
    describe "#all_cards" do
      let(:list_id) { "some_24bit_list_id" }
      let(:card) { OpenStruct.new(id:       "some_24bit_card_id",
                                  short_id: "212",
                                  name:     "Finish Trlo") }
      let(:cards) { [card, card] }
      let(:list) { OpenStruct.new(id:    "some_24bit_list_id",
                                  name:  "Development",
                                  cards: cards) }
      subject { FindCards.for(list_id) }

      before do
        FindList.stubs(:with).returns(list)
      end

      it "finds the cards by list_id" do
        subject.size.must_equal 2
      end
    end
  end

  describe MoveCard do
    describe "#move" do
      subject { MoveCard.with(card_id, list_id) }

      describe "when a list_id is supplied" do
        it "moves the card to the specified list" do
          skip("Please write spec.")
        end
      end

      describe "when a list_id is not supplied" do
        it "presents the user with a list of options" do
          skip("Please write spec.")
        end

        it "moves the card to the specified lists" do
          skip("Please write spec.")
        end
      end
    end
  end
end

