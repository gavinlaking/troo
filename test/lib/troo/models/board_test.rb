require_relative "../../../test_helper"

module Troo
  describe Board do
    let(:described_class) { Board }
    let(:described_instance) { Fabricate.build(:board) }

    subject { described_instance }

    context "attributes" do
      it "should have a name attribute" do
        subject.name.must_equal "My Test Board"
      end

      it "should have a description attribute" do
        subject.description.must_equal "A very brief description..."
      end

      it "should have a default attribute" do
        subject.default.must_equal false
      end

      it "should have a closed attribute" do
        subject.closed.must_equal false
      end

      it "should have an external_board_id attribute" do
        subject.external_board_id.must_equal "526d8e130a14a9d846001d96"
      end
    end

    context "associations" do
      before do
        @list  = Fabricate(:list)
        @card  = Fabricate(:card)
      end

      after { database_cleanup }

      it "can have many lists" do
        subject.lists.size.must_equal 1
      end

      it "can have many cards" do
        subject.cards.size.must_equal 1
      end
    end
  end
end

