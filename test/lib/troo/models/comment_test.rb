require_relative "../../../test_helper"

module Troo
  describe Comment do
    let(:described_class) { Comment }

    before do
      @comment = Fabricate(:comment)
      @board   = Fabricate(:board)
      @card    = Fabricate(:card)
      @member  = Fabricate(:member)
    end

    after do
      database_cleanup
    end

    it "should have a text attribute" do
      @comment.text.must_equal "My Test Comment"
    end

    it "should have a date attribute" do
      @comment.date.must_equal DateTime.civil(2013, 12, 17, 22, 1, 13)
    end

    it "should have an external_board_id attribute" do
      @comment.external_board_id.must_equal "526d8e130a14a9d846001d96"
    end

    it "should have an external_card_id attribute" do
      @comment.external_card_id.must_equal "526d8f19ddb279532e005259"
    end

    it "should have an external_comment_id attribute" do
      @comment.external_comment_id.must_equal "51f9277b2822b8654f0023af"
    end

    it "should have a external_member_id attribute" do
      @comment.external_member_id.must_equal "5195fdb5a8c01a2318004f5d"
    end

    describe "#board" do
      it "belongs to a board" do
        @comment.board.must_equal @board
      end
    end

    describe "#card" do
      it "belongs to a card" do
        @comment.card.must_equal @card
      end
    end

    describe "#member" do
      it "belongs to a member" do
        @comment.member.must_equal @member
      end
    end
  end
end

