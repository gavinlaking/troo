require_relative "../../../test_helper"

module Ctrlo
  describe ExternalComment do
    let(:described_class) { ExternalComment }

    describe ".initialize" do
      subject { described_class.new("some_id") }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal "some_id"
      end
    end

    describe "when the mode is board" do
      before { VCR.insert_cassette(:comments_by_board_id) }
      after  { VCR.eject_cassette }
    end

    describe "when the mode is card" do
      before { VCR.insert_cassette(:comments_by_card_id) }
      after  { VCR.eject_cassette }
    end
  end
end
