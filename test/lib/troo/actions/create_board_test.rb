require_relative "../../../test_helper"

module Troo
  describe CreateBoard do
    let(:described_class) { CreateBoard }
    let(:board_name)      { "My New Board" }
    let(:description)     { "A very brief description..." }

    before do
      @board = Fabricate(:board, name: board_name, description: description)
      Trello::Board.stubs(:create).returns(@board)
      Input.stubs(:get).returns()
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(board_name, description) }

      it "assigns the name to an instance variable" do
        subject.instance_variable_get("@name").must_equal(board_name)
      end

      it "assigns the description to an instance variable" do
        subject.instance_variable_get("@description").must_equal(description)
      end
    end

    describe "#create" do
      before { VCR.insert_cassette(:create_board) }
      after  { VCR.eject_cassette }

      subject { described_class.with(board_name, description) }

      context "when a new board description is provided" do
        it "creates the board and returns an instance of this class" do
          subject.must_be_instance_of(described_class)
        end
      end

      context "when a new board description is not provided" do
        let(:description) { nil }
        let(:user_input_description) { "A very brief description..." }

        before do
          Input.stubs(:get).returns(user_input_description)
        end

        it "asks the user to enter a description and creates the board" do
          subject.must_be_instance_of(described_class)

          subject.description.must_equal(user_input_description)
        end
      end
    end

    context "it exposes various attributes we will use later" do
      subject { described_class.new(board_name, description) }

      describe "#description" do
        it "returns the description" do
          subject.description.must_equal(description)
        end
      end
    end
  end
end
