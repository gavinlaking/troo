require_relative "../../../test_helper"

module Troo
  describe RefreshAll do
    let(:described_class) { RefreshAll }
    let(:options) { { } }

    before do
      @board = Fabricate(:board)
      @list = Fabricate(:list)
      @card = Fabricate(:card)

      ExternalBoard.stubs(:fetch_all).returns([@board])
      ExternalList.stubs(:fetch).returns([@list])
      ExternalCard.stubs(:fetch).returns([@card])
      ExternalComment.stubs(:fetch).returns([])
      ExternalMember.stubs(:fetch).returns([])
    end

    after { database_cleanup }

    describe ".initialize" do
      subject { described_class.new(@board, options) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(@board)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe ".all" do
      let(:board) { nil }

      subject { described_class.all(board, options) }

      it "returns true when successful" do
        subject.must_equal(true)
      end
    end

    describe ".default" do
      subject { described_class.default(@board, options) }

      it "returns true when successful" do
        subject.must_equal(true)
      end
    end

    describe ".lists" do
      subject { described_class.lists(@board, options) }

      it "refreshes the lists for the board specified" do
          subject.size.must_equal(1)
      end
    end

    describe ".cards" do
      subject { described_class.cards(@board, options) }

      it "refreshes the cards for the board specified" do
        subject.size.must_equal(1)
      end
    end
  end
end
