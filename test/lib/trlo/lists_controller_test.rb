require_relative "../../test_helper.rb"

module Trlo
  describe ListsController do
    describe "#dispatch" do
      let(:options)   { { all: true } }
      let(:arguments) { [board_id] }
      let(:board_id)  { "some_24bit_string" }

      subject { ListsController.new(options, arguments).dispatch }

      describe ":all" do
        let(:board)     { OpenStruct.new(id: board_id) }
        let(:list_1)    { OpenStruct.new(id: "some_24bit_string1", name: "Backlog") }
        let(:list_2)    { OpenStruct.new(id: "some_24bit_string2", name: "In Progress") }
        let(:list_hash) { [list_1, list_2] }

        before do
          Trello::Board.stubs(:find).returns(board)
          board.stubs(:lists).returns(list_hash)
        end

        it "shows all the lists for the board" do
          proc { subject }.must_output <<-TABLE.gsub(/^ {12}/, "")
            +--------------------+-------------+
            | ID                 | Name        |
            +--------------------+-------------+
            | some_24bit_string1 | Backlog     |
            | some_24bit_string2 | In Progress |
            +--------------------+-------------+
          TABLE
        end
      end
    end
  end
end

