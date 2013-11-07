require_relative "../../../test_helper"

module Trlo
  describe Comment do
    describe ".all" do
      let(:card_id) { "some_24bit_card_id" }

      subject { Comment.all(card_id) }

      it "gets all the comments for the specified card" do
        skip("Please write spec.")
      end
    end
  end
end

