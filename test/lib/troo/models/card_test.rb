require_relative "../../../test_helper"

module Troo
  describe Card do
    let(:described_class) { Card }

    before do
      Ohm.redis.flushdb
      @card = Troo::Card.create({
        short_id: "1",
        name: "My Test Card",
        desc: "some description",
        url: "some trello url",
        external_member_ids: ["5195fdb5a8c01a2318004f5d"],
        position: 16,
        last_activity_date: "",
        current: false,
        closed: false,
        external_board_id: "526d8e130a14a9d846001d96",
        external_list_id: "526d8e130a14a9d846001d97",
        external_card_id: "526d8f19ddb279532e005259"
      })
      @board = Troo::Board.create({
        external_board_id: "526d8e130a14a9d846001d96"
      })
      @list = Troo::List.create({
        external_list_id: "526d8e130a14a9d846001d97"
      })
      @comment = Troo::Comment.create({
        external_card_id: "526d8f19ddb279532e005259"
      })
    end

    after do
      @card.delete
      @board.delete
      @list.delete
      @comment.delete
    end

    it "should have a short_id attribute" do
      @card.short_id.must_equal "1"
    end

    it "should have a name attribute" do
      @card.name.must_equal "My Test Card"
    end

    it "should have a desc attribute" do
      @card.desc.must_equal "some description"
    end

    it "should have a url attribute" do
      @card.url.must_equal "some trello url"
    end

    it "should have an external_member_ids attribute" do
      @card.external_member_ids.must_equal(["5195fdb5a8c01a2318004f5d"])
    end

    it "should have a position attribute" do
      @card.position.must_equal 16
    end

    it "should have a last_activity_date attribute" do
      @card.last_activity_date.must_equal ""
    end

    it "should have a current attribute" do
      @card.current.must_equal false
    end

    it "should have a closed attribute" do
      @card.closed.must_equal false
    end

    it "should have an external_board_id attribute" do
      @card.external_board_id.must_equal "526d8e130a14a9d846001d96"
    end

    it "should have an external_list_id attribute" do
      @card.external_list_id.must_equal "526d8e130a14a9d846001d97"
    end

    it "should have an external_card_id attribute" do
      @card.external_card_id.must_equal "526d8f19ddb279532e005259"
    end

    describe "#board" do
      it "belongs to a board" do
        @card.board.must_equal @board
      end
    end

    describe "#list" do
      it "belongs to a list" do
        @card.list.must_equal @list
      end
    end

    describe "#comments" do
      it "can have many comments" do
        @card.comments.size.must_equal 1
      end
    end

    describe "#members" do
      it "can have many members" do
        skip
      end
    end
  end
end

