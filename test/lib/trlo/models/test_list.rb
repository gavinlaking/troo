require_relative "../../../test_helper"

module Trlo
  describe FindList do
    describe ".all" do
      let(:board_id) { "some_24bit_board_id" }

      subject { FindList.all(board_id) }

      it "gets all lists for the specified board" do
        skip("Please write spec.")
      end
    end
  end

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
end

