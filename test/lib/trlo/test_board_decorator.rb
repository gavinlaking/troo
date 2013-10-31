require_relative "../../test_helper"

module Trlo
  describe BoardDecorator do
    let(:board) { OpenStruct.new(id:   "some_24bit_string",
                                 name: "Development Board") }

    describe "#id" do
      it "returns the Trello ID of the board" do
        BoardDecorator.new(board).id.must_equal "some_24bit_string"
      end
    end

    describe "#name" do
      it "returns the name of the board" do
        BoardDecorator.new(board).name.must_equal "Development Board"
      end
    end
  end
end

