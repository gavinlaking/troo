require_relative "../../test_helper"

module Trlo
  describe ListDecorator do
    let(:list) { OpenStruct.new(id:   "some_24bit_string",
                                 name: "Backlog") }

    describe "#id" do
      it "returns the Trello ID of the list" do
        ListDecorator.new(list).id.must_equal "some_24bit_string"
      end
    end

    describe "#name" do
      it "returns the name of the list" do
        ListDecorator.new(list).name.must_equal "Backlog"
      end
    end

    describe "#to_hash" do
      it "returns a hash containing data from the list" do
        ListDecorator.new(list).
          to_hash.must_equal({ id:   "some_24bit_string",
                               name: "Backlog" })
      end
    end
  end
end
