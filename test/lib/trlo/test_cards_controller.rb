require_relative "../../test_helper.rb"

module Trlo
  describe CardsController do
    describe "#dispatch" do
      let(:options)   { { all: true } }
      let(:arguments) { [list_id] }
      let(:list_id)  { "some_24bit_string" }

      subject { CardsController.new(options, arguments).dispatch }

      describe "all" do
        let(:list)      { OpenStruct.new(id: list_id) }
        let(:card_1)    { OpenStruct.new(id: "some_24bit_string1",
                                         short_id: "17",
                                         name: "Finish Trlo") }
        let(:card_2)    { OpenStruct.new(id: "some_24bit_string2",
                                         short_id: "18",
                                         name: "Drink Beer") }
        let(:card_hash) { [card_1, card_2] }

        before do
          Trello::List.stubs(:find).returns(list)
          list.stubs(:cards).returns(card_hash)
        end

        it "shows all the cards for the list" do
          proc { subject }.must_output <<-TABLE.gsub(/^ {12}/, "")
            +----+-------------+
            | ID | Name        |
            +----+-------------+
            | 17 | Finish Trlo |
            | 18 | Drink Beer  |
            +----+-------------+
          TABLE
        end
      end

      describe "comment" do
        let(:options) { { comment: true } }

        it "comments on a card" do
          skip("Please write spec.")
        end
      end

      describe "move" do
        let(:options) { { move: true } }

        it "moves a card from a list to another list" do
          skip("Please write spec.")
        end
      end
    end
  end
end

