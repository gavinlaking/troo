require_relative "../../../test_helper"

module Troo
  describe CreateList do
    let(:described_class) { CreateList }
    let(:board_id)  { "526d8e130a14a9d846001d96" }
    let(:list_name) { "My New List" }

    before do
      @board = Fabricate(:board)
      @list = Fabricate(:list)

      Trello::List.stubs(:create).returns(@list)
      Troo::BoardRetrieval.stubs(:retrieve).returns(@board)
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(board_id, list_name) }

      it "assigns the board_id" do
        subject.instance_variable_get("@board_id").must_equal(board_id)
      end

      it "assigns the name" do
        subject.instance_variable_get("@name").must_equal(list_name)
      end
    end

    describe "#create" do
      before { VCR.insert_cassette(:create_list, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.for(board_id, list_name) }

      context "when a new list name is provided" do
        it "creates the list and returns an instance of this class" do
          subject.must_be_instance_of(described_class)
        end
      end

      context "when a new list name is not provided" do
        let(:list_name) { nil }
        let(:user_input_list_name) { "My New List" }

        before do
          Input.stubs(:get).returns(user_input_list_name)
        end

        it "asks the user to enter a name and creates the list" do
          subject.must_be_instance_of(described_class)

          subject.name.must_equal(user_input_list_name)
        end
      end
    end

    context "it exposes various attributes we will use later" do
      subject { described_class.new(board_id, list_name) }

      describe "#board_name" do
        it "returns the board name" do
          subject.board_name.must_equal(@board.name)
        end
      end

      describe "#external_board_id" do
        it "returns the external_board_id" do
          subject.external_board_id.must_equal(board_id)
        end
      end

      describe "#name" do
        it "returns the name" do
          subject.name.must_equal(list_name)
        end
      end
    end
  end
end
