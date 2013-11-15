require_relative "../../../test_helper"

module Trlo
  describe FindCards do
    describe "#all_cards" do
      subject { FindCards.for("526d8e130a14a9d846001d97") }

      before do
        VCR.insert_cassette(:find_cards_for_list_id)
      end

      after do
        VCR.eject_cassette
      end

      it "finds the cards by list_id" do
        subject.size.must_equal 6
      end
    end
  end
end
