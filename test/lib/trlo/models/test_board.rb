require_relative "../../../test_helper"

module Trlo
  describe Board do
    let(:board) { OpenStruct.new(id:   "some_24bit_board_id",
                                 name: "Development Board") }

    describe "#decorate" do
      it "returns a hash containing data from the board" do
        Board.new(board).
          decorate.must_equal({ id:     "some_24bit_board_id",
                                name:   "Development Board",
                                header: { id: "ID", name: "Name" } })
      end
    end

    describe "#id" do
      it "returns the Trello ID of the board" do
        Board.new(board).id.must_equal "some_24bit_board_id"
      end
    end

    describe "#name" do
      it "returns the name of the board" do
        Board.new(board).name.must_equal "Development Board"
      end
    end
  end

  describe FindBoard do
    describe ".with" do
      let(:board_id) { "some_24bit_board_id" }
      let(:board) { OpenStruct.new(id:   "some_24bit_board_id",
                                   name: "Development Board") }

      before do
        Trello::Board.stubs(:find).returns(board)
      end

      subject { FindBoard.with(board_id) }

      it "finds the board by specifed board_id" do
        subject.name.must_equal "Development Board"
      end
    end
  end

  describe FindBoards do
    describe ".all" do
      let(:board) { OpenStruct.new(id:   "some_24bit_board_id",
                                   name: "Development Board") }
      let(:boards) { [board, board] }

      subject { FindBoards.all }

      before do
        Trello::Board.stubs(:all).returns(boards)
      end

      it "returns all the boards for the authenticated user" do
        subject.size.must_equal 2
      end
    end
  end
end
