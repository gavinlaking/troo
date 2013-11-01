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
        let(:card_1)    { OpenStruct.new(id: "some_24bit_string1", name: "Finish Trlo") }
        let(:card_2)    { OpenStruct.new(id: "some_24bit_string2", name: "Drink Beer") }
        let(:card_hash) { [card_1, card_2] }

        before do
          Trello::List.stubs(:find).returns(list)
          list.stubs(:cards).returns(card_hash)
        end

        it "shows all the cards for the specified list" do
          proc { subject }.must_output <<-TABLE.gsub(/^ {12}/, "")
            +--------------------+-------------+
            | ID                 | Name        |
            +--------------------+-------------+
            | some_24bit_string1 | Finish Trlo |
            | some_24bit_string2 | Drink Beer  |
            +--------------------+-------------+
          TABLE
        end
      end

      describe "comment" do
        let(:options) { { comment: true } }

        it "comments on a card" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "move" do
        let(:options) { { move: true } }

        it "moves a card from a list to another list" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "create" do
        let(:options) { { create: true } }

        it "adds a new card" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "delete" do
        let(:options) { { delete: true } }

        it "deletes a card" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "show" do
        let(:options) { { show: true } }

        it "shows a card's details" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end
    end
  end
end

