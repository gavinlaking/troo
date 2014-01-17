require_relative "../../../test_helper"

module Troo
  module External
    describe Board do
      let(:described_class) { Board }
      let(:board_id)        { "526d8e130a14a9d846001d96" }
      let(:options)         { { } }

      describe ".initialize" do
        subject { described_class.new(board_id, options) }

        it "assigns the external_id" do
          subject.instance_variable_get("@external_id").must_equal(board_id)
        end

        it "assigns the options" do
          subject.instance_variable_get("@options").must_equal(options)
        end
      end

      describe ".fetch" do
        before { VCR.insert_cassette(:board_by_id, decode_compressed_response: true) }
        after  { VCR.eject_cassette }

        subject { described_class.fetch(board_id, options) }

        it "returns a single board" do
          subject.size.must_equal(1)
        end

        it "returns a board with the board_id" do
          subject.first.external_board_id.must_equal(board_id)
        end

        it "returns a board with the correct name" do
          subject.first.name.must_equal("Troo App")
        end

        context "when the board cannot be found" do
          before { Trello::Board.stubs(:find).raises(Trello::Error) }

          it "returns an empty collection" do
            subject.must_equal([])
          end
        end
      end

      describe ".fetch_all" do
        before { VCR.insert_cassette(:boards_all, decode_compressed_response: true) }
        after  { VCR.eject_cassette }

        subject { described_class.fetch_all }

        it "returns multiple boards" do
          subject.size.must_equal(1)
        end

        context "when no boards can be found" do
          before { Trello::Board.stubs(:all).raises(Trello::Error) }

          it "returns an empty collection" do
            subject.must_equal([])
          end
        end
      end
    end
  end
end
