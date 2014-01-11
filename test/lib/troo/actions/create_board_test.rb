require_relative "../../../test_helper"

module Troo
  describe CreateBoard do
    let(:described_class) { CreateBoard }
    let(:board_name)      { "My New Board" }
    let(:description)     { "A very brief description..." }

    before do
      @board = Fabricate(:board, name: board_name, description: description)
      Troo::BoardPersistence.stubs(:for).returns(@board)
    end

    after { database_cleanup }

    describe ".initialize" do
      subject { described_class.new(board_name, description) }

      it "assigns the name to an instance variable" do
        subject.instance_variable_get("@name").must_equal(board_name)
      end

      it "assigns the description to an instance variable" do
        subject.instance_variable_get("@description").must_equal(description)
      end
    end

    describe ".with" do
      before { VCR.insert_cassette(:create_board, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.with(board_name, description) }

      context "when the board was created" do
        it "returns the new board" do
          subject.must_equal(@board)
        end
      end

      context "when the board was not created" do
        before { Trello::Board.stubs(:create).raises(Trello::Error) }

        it { subject.must_equal false }
      end
    end
  end
end
