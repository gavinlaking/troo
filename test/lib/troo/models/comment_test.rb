require_relative "../../../test_helper"

module Troo
  describe Comment do
    let(:described_class) { Comment }

    before do
      database_cleanup
      @comment = Troo::Comment.create({
        text: "some comment text",
        date: "",
        external_board_id: "526d8e130a14a9d846001d96",
        external_card_id: "526d8f19ddb279532e005259",
        external_comment_id: "51f9277b2822b8654f0023af",
        external_member_id: "5195fdb5a8c01a2318004f5d"
      })
      @board = Troo::Board.create({
        external_board_id: "526d8e130a14a9d846001d96"
      })
      @card = Troo::Card.create({
        external_card_id: "526d8f19ddb279532e005259"
      })
      @member = Troo::Member.create({
        external_member_id: "5195fdb5a8c01a2318004f5d"
      })
    end

    after do
      @comment.delete
      @board.delete
      @card.delete
      @member.delete
    end

    it "should have a text attribute" do
      @comment.text.must_equal "some comment text"
    end

    it "should have a date attribute" do
      @comment.date.must_equal ""
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

