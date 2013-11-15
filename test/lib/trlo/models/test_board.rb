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
      subject { FindBoard.with("526d8e130a14a9d846001d96") }

      before do
        VCR.insert_cassette(:find_board)
      end

      after do
        VCR.eject_cassette
      end

      it "finds the board by specifed board_id" do
        subject.name.must_equal "Trlo App"
      end
    end
  end

  describe FindBoards do
    describe ".all" do
      subject { FindBoards.all }

      before do
        VCR.insert_cassette(:find_all_boards)
      end

      after do
        VCR.eject_cassette
      end

      it "returns all the boards for the authenticated user" do
        subject.size.must_equal 2
      end

      it "decorates the returned boards" do
        subject.last.fetch(:name).must_equal "Welcome Board"
      end
    end
  end
end

