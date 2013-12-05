require_relative "../../../test_helper"

module Ctrlo
  describe List do
    let(:described_class) { List }

    describe ".retrieve" do
      describe "local retrieval by database ID" do
      end

      describe "local retrieval by external ID" do
      end

      describe "remote retrieval by either ID" do
      end
    end

    describe ".retrieve_all" do
      it "retrieves all locally stored lists" do
      end
    end

    describe ".persist" do
    end

    describe "#current" do
      describe "when there is a current list set" do
      end

      describe "when there is not a current list set" do
      end
    end

    describe "#content" do
    end

    describe "#header" do
      before do
        @board = Board.create({ name: "My Test Board" })
        @list  = @board.lists.create({ name: "My Test List" })
      end

      subject { @list.header }

      it "returns a header" do
        subject.must_equal({ id: "", name: "My Test Board" })
      end
    end
  end
end

