require_relative "../../../test_helper"

module Trlo
  describe List do
    let(:list) { OpenStruct.new(id:   "some_24bit_string",
                                name: "Backlog") }

    describe "#id" do
      it "returns the Trello ID of the list" do
        List.new(list).id.must_equal "some_24bit_string"
      end
    end

    describe "#name" do
      it "returns the name of the list" do
        List.new(list).name.must_equal "Backlog"
      end
    end

    describe "#decorate" do
      it "returns a hash containing data from the list" do
        List.new(list).
          decorate.must_equal({ id:     "some_24bit_string",
                                name:   "Backlog",
                                header: { id: "ID", name: "Name" } })
      end
    end
  end

  describe FindList do
    describe "#find" do
      let(:list_id) { "some_24bit_list_id" }

      subject { FindList.with(list_id) }

      it "finds the list by list_id" do
        skip("Please write spec.")
      end
    end
  end

  describe FindLists do
    describe "#all_lists" do
      let(:board_id) { "some_24bit_board_id" }

      subject { FindLists.for(board_id) }

      it "finds all the lists by board_id" do
        skip("Please write spec.")
      end
    end
  end
end

