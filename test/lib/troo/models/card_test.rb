require_relative "../../../test_helper"

module Troo
  describe Card do
    let(:described_class) { Card }

    before do
      @card    = Fabricate(:card)
      @board   = Fabricate(:board)
      @list    = Fabricate(:list)
      @comment = Fabricate(:comment)
      @member  = Fabricate(:member)
    end

    after do
      database_cleanup
    end

    it "should have a short_id attribute" do
      @card.short_id.must_equal "67"
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
      @card.last_activity_date.must_equal "2013-12-17 21:48:09 UTC"
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
      context "when the card has members" do
        it "returns the collection of members" do
          @card.members.size.must_equal 1
        end
      end

      context "when the card has no members" do
        before do
          @card.stubs(:external_member_ids).returns([])
        end

        it "returns an empty collection" do
          @card.members.size.must_equal 0
        end
      end
    end
  end
end

