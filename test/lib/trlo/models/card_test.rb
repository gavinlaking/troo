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
                                comments: [],
                                header:   { short_id: "ID", name: "Name" } })
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

  describe ShowCard do
    describe "#show" do
      let(:card_id)  { "some_24bit_card_id" }
      let(:card)     { OpenStruct.new({
                         id:       "some_24bit_card_id",
                         short_id: "1",
                         name:     "Implement 'ShowCard'",
                         comments: comments }) }
      let(:comment)  { Comment.decorate(OpenStruct.new({
                         member_creator_id: "some_24bit_member_id",
                         data:              { "text" => "Writing some tests." },
                         date:              Time.parse("2013-11-12 20:26:58 UTC") })) }
      let(:comments) { [comment] }

      subject { ShowCard.with(card_id) }

      before do
        FindCard.stubs(:with).returns(card)
        FindComments.stubs(:for).returns(comments)
        # card.stubs(:actions).returns(comments)
      end

      it "presents the card by card_id" do
        subject.must_equal({ :id       => "some_24bit_card_id",
                             :short_id => "1",
                             :name     => "Implement 'ShowCard'",
                             :comments => [{ :member   => "some_24bit_member_id",
                                             :text     => "Writing some tests.",
                                             :date     => "2013-11-12 20:26:58 UTC" }],
                             :header   => { :short_id => "ID",
                                            :name     => "Name" } })
      end
    end
  end
end

