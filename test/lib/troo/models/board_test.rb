require_relative "../../../test_helper"

module Troo
  describe Board do
    let(:described_class) { Board }

    before do
      database_cleanup
      @board = Troo::Board.create({
        name: "My Test Board",
        current: false,
        closed: false,
        external_board_id: "526d8e130a14a9d846001d96"
      })
      @list = Troo::List.create({
        external_board_id: "526d8e130a14a9d846001d96"
      })
      @card = Troo::Card.create({
        external_board_id: "526d8e130a14a9d846001d96"
      })
    end

    after do
      @board.delete
      @list.delete
      @card.delete
    end

    it "should have a name attribute" do
      @board.name.must_equal "My Test Board"
    end

    it "should have a current attribute" do
      @board.current.must_equal false
    end

    it "should have a closed attribute" do
      @board.closed.must_equal false
    end

    it "should have an external_board_id attribute" do
      @board.external_board_id.must_equal "526d8e130a14a9d846001d96"
    end

    describe "#lists" do
      it "can have many lists" do
        @board.lists.size.must_equal 1
      end
    end

    describe "#cards" do
      it "can have many cards" do
        @board.cards.size.must_equal 1
      end
    end
  end
end

