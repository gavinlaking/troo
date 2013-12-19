require_relative "../../../test_helper"

module Troo
  describe List do
    let(:described_class) { List }

    before do
      Ohm.redis.flushdb
      @list = Troo::List.create({
        name: "My Test List",
        position: 32768,
        current: false,
        closed: false,
        external_board_id: "526d8e130a14a9d846001d96",
        external_list_id: "526d8e130a14a9d846001d97"
      })
      @board = Troo::Board.create({
        external_board_id: "526d8e130a14a9d846001d96"
      })
      @card = Troo::Card.create({
        external_list_id: "526d8e130a14a9d846001d97"
      })
    end

    after do
      @list.delete
      @board.delete
      @card.delete
    end

    it "should have a name attribute" do
      @list.name.must_equal "My Test List"
    end

    it "should have a position attribute" do
      @list.position.must_equal 32768
    end

    it "should have a current attribute" do
      @list.current.must_equal false
    end

    it "should have a closed attribute" do
      @list.closed.must_equal false
    end

    it "should have a external_board_id attribute" do
      @list.external_board_id.must_equal "526d8e130a14a9d846001d96"
    end

    it "should have an external_list_id attribute" do
      @list.external_list_id.must_equal "526d8e130a14a9d846001d97"
    end

    describe "#board" do
      it "belongs to a board" do
        @list.board.must_equal @board
      end
    end

    describe "#cards" do
      it "can have many cards" do
        @list.cards.size.must_equal 1
      end
    end
  end
end
