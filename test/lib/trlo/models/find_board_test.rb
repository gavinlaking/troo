require_relative "../../../test_helper"

module Trlo
  describe FindBoard do
    describe ".with" do
      subject { FindBoard.with("526d8e130a14a9d846001d96") }

      before do
        VCR.insert_cassette(:find_board)
      end

      after do
        VCR.eject_cassette
      end

      it "finds the board by specifed board_id" do
        subject.name.must_equal "Trlo App"
      end
    end
  end
end
