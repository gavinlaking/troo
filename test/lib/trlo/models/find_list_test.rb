require_relative "../../../test_helper"

module Trlo
  describe FindList do
    describe "#find" do
      subject { FindList.with("526d8e130a14a9d846001d97") }

      before do
        VCR.insert_cassette(:find_list)
      end

      after do
        VCR.eject_cassette
      end

      it "finds the list by list_id" do
        subject.name.must_equal "To Do"
      end
    end
  end
end
