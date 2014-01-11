require_relative "../../../test_helper"

module Troo
  describe CreateList do
    let(:described_class) { CreateList }
    let(:board_id)  { "526d8e130a14a9d846001d96" }
    let(:list_name) { "My New List" }

    before do
      @board = Fabricate(:board)
      @list = Fabricate(:list, name: list_name)

      Troo::ListPersistence.stubs(:for).returns(@list)
    end

    after { database_cleanup }

    describe ".initialize" do
      subject { described_class.new(@board, list_name) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(@board)
      end

      it "assigns the name to an instance variable" do
        subject.instance_variable_get("@name").must_equal(list_name)
      end
    end

    describe ".for" do
      before { VCR.insert_cassette(:create_list, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.for(@board, list_name) }

      context "when the list was created" do
        it "returns the new list" do
          subject.must_equal(@list)
        end
      end

      context "when the list was not created" do
        before { Trello::List.stubs(:create).raises(Trello::Error) }

        it { subject.must_equal false }
      end
    end
  end
end
