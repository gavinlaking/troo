require_relative "../../../test_helper"

module Troo
  module External
    describe List do
      let(:described_class) { List }

      describe ".initialize" do
        subject { described_class.new("some_id", {}) }

        it "assigns the external_id" do
          subject.instance_variable_get("@external_id").must_equal "some_id"
        end

        it "assigns the options" do
          subject.instance_variable_get("@options").must_equal({})
        end
      end

      describe "when the mode is board" do
        before { VCR.insert_cassette(:lists_by_board_id, decode_compressed_response: true) }
        after  { VCR.eject_cassette }

        let(:board_id) { "526d8e130a14a9d846001d96" }
        let(:options)  { { mode: :board } }

        subject { described_class.fetch(board_id, options) }

        it "returns multiple lists" do
          subject.size.must_equal(4)
        end

        context "when the board cannot be found" do
          before { Trello::Board.stubs(:find).raises(Trello::Error) }

          it "returns an empty collection" do
            subject.must_equal([])
          end
        end
      end

      describe "when the mode is list" do
        before { VCR.insert_cassette(:list_by_list_id, decode_compressed_response: true) }
        after  { VCR.eject_cassette }

        let(:list_id) { "526d8e130a14a9d846001d97" }
        let(:options) { { mode: :list } }

        subject { described_class.fetch(list_id, options) }

        it "returns a list with the list_id" do
          subject.size.must_equal(1)
        end

        context "when the list cannot be found" do
          before { Trello::List.stubs(:find).raises(Trello::Error) }

          it "returns an empty collection" do
            subject.must_equal([])
          end
        end
      end
    end
  end
end
