require_relative "../../../test_helper"

module Trlo
  describe FindLists do
    describe "#all_lists" do    
      before do
        VCR.insert_cassette(:find_lists_for_board_id)
      end

      after do
        VCR.eject_cassette
      end

      subject { FindLists.for("526d8e130a14a9d846001d96") }

      it "finds all the lists by board_id" do
        subject.size.must_equal 3
      end

      it "decorates the returned lists" do
        subject.last.fetch(:name).must_equal "Done"
      end
    end
  end
end
