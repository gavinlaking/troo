require_relative "../../test_helper.rb"

module Trlo
  describe CardsController do
    describe "#dispatch" do
      let(:arguments) { }

      subject { CardsController.new(options, arguments).dispatch }

      describe "add" do
        let(:options) { {add: true, delete: nil, show: nil, comment: nil, move: nil} }

        it "adds a new card" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "delete" do
        let(:options) { {add: nil, delete: true, show: nil, comment: nil, move: nil} }

        it "deletes a card" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "show" do
        let(:options) { {add: nil, delete: nil, show: true, comment: nil, move: nil} }

        it "shows a card's details" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "comment" do
        let(:options) { {add: nil, delete: nil, show: nil, comment: true, move: nil} }

        it "comments on a card" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end

      describe "move" do
        let(:options) { {add: nil, delete: nil, show: nil, comment: nil, move: true} }

        it "moves a card from a list to another list" do
          proc { subject }.must_output "Not implemented yet.\n"
        end
      end
    end
  end
end

