require_relative "../../../test_helper"

module Trlo
  describe FindBoards do
    describe ".all" do
      subject { FindBoards.all }

      before do
        VCR.insert_cassette(:find_all_boards)
      end

      after do
        VCR.eject_cassette
      end

      it "returns all the boards for the authenticated user" do
        subject.size.must_equal 2
      end

      it "decorates the returned boards" do
        subject.last.fetch(:name).must_equal "Welcome Board"
      end
    end
  end
end
