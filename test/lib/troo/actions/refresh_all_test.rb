require_relative "../../../test_helper"

module Troo
  describe RefreshAll do
    let(:described_class) { RefreshAll }
    let(:options) { { } }

    before do
      @board = Fabricate(:board)
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(options) }

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe ".perform" do
      subject { described_class.perform(options) }

      before do
        ExternalBoard.stubs(:fetch_all).returns([@board])
        ExternalList.stubs(:fetch).returns()
        ExternalCard.stubs(:fetch).returns()
        ExternalComment.stubs(:fetch).returns()
        ExternalMember.stubs(:fetch).returns()
      end

      it "returns true when successful" do
        subject.must_equal(true)
      end

      it "fetches all the boards" do
        skip
      end

      it "fetches all the lists" do
        skip
      end

      it "fetches all the cards" do
        skip
      end

      it "fetches all the comments" do
        skip
      end

      it "fetches all the members" do
        skip
      end
    end
  end
end
