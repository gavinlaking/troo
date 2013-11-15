require_relative "../../../test_helper"

module Trlo
  describe FindComments do
    describe "#all_comments" do
      subject { FindComments.for("526d8f19ddb279532e005259") }

      before do
        VCR.insert_cassette(:find_comments_for_card_id)
      end

      after do
        VCR.eject_cassette
      end

      it "finds all the comments by card_id" do
        subject.size.must_equal 2
      end
    end
  end
end
