require_relative "../../../test_helper"

module Trlo
  describe FindCard do
    describe ".with" do
      subject { FindCard.with("526d8f19ddb279532e005259") }

      before do
        VCR.insert_cassette(:find_card)
      end

      after do
        VCR.eject_cassette
      end

      it "finds the card by card_id" do
        subject.name.must_equal "lists --show <list_id>"
      end
    end
  end
end
