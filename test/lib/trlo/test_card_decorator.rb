require_relative "../../test_helper"

module Trlo
  describe CardDecorator do
    let(:card) { OpenStruct.new(id:   "some_24bit_string",
                                short_id: "212",
                                name: "Finish Trlo") }

    describe "#short_id" do
      it "returns the Trello short ID of the card" do
        CardDecorator.new(card).short_id.must_equal "212"
      end
    end

    describe "#id" do
      it "returns the Trello ID of the card" do
        CardDecorator.new(card).id.must_equal "some_24bit_string"
      end
    end

    describe "#name" do
      it "returns the name of the list" do
        CardDecorator.new(card).name.must_equal "Finish Trlo"
      end
    end

    describe "#to_hash" do
      it "returns a hash containing data from the card" do
        CardDecorator.new(card).
          to_hash.must_equal({ id:   "some_24bit_string",
                               short_id: "212",
                               name: "Finish Trlo" })
      end
    end
  end
end
