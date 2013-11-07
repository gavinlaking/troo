require_relative "../../test_helper.rb"

module Trlo
  describe BoardsController do
    describe "#dispatch" do
      let(:arguments) {}

      subject { BoardsController.new(options, arguments).dispatch }

      describe ":all" do
        let(:options)    { { all: true, show: nil, lists: nil } }
        let(:board_1)    { OpenStruct.new(id: "f1e1e1d1", name: "Board 1") }
        let(:board_2)    { OpenStruct.new(id: "f2e2e2d2", name: "Board 2") }
        let(:board_hash) { [board_1, board_2] }

        before do
          Trello::Board.stubs(:all).returns(board_hash)
        end

        it "shows all the boards for the configured user" do
          proc { subject }.must_output <<-TABLE.gsub(/^ {12}/, "")
            +----------+---------+
            | ID       | Name    |
            +----------+---------+
            | f1e1e1d1 | Board 1 |
            | f2e2e2d2 | Board 2 |
            +----------+---------+
          TABLE
        end
      end
    end
  end
end
