require_relative "../../../test_helper"

module Troo
  describe Board do
    let(:described_class) { Board }

    before do
      @board = Fabricate(:board)
      @list  = Fabricate(:list)
      @card  = Fabricate(:card)
    end

    after do
      database_cleanup
    end

    it "should have a name attribute" do
      @board.name.must_equal "My Test Board"
    end

    it "should have a description attribute" do
      @board.description.must_equal "A very brief description..."
    end

    it "should have a default attribute" do
      @board.default.must_equal false
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

