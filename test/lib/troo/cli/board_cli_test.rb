require_relative "../../../test_helper"

module Troo
  module CLI
    describe Board do
      let(:described_class) { Board }
      let(:board_id)        { "526d8e130a14a9d846001d96" }
      let(:list_id)         { "526d8e130a14a9d846001d97" }
      let(:card_id)         { "526d8f19ddb279532e005259" }

      before do
        @board   = Fabricate(:board)
        @board_2 = Fabricate(:board, name: "My Other Board")
        @list    = Fabricate(:list)
        @card    = Fabricate(:card)
      end

      after do
        database_cleanup
      end

      describe ".all" do
        subject { capture_io { described_class.new.all }.join }

        context "when boards exist" do
          it "returns a list of boards" do
            subject.must_match /Test Board/
            subject.must_match /Other Board/
          end
        end

        context "when no boards exist" do
          before do
            Troo::BoardRetrieval.stubs(:retrieve).returns([])
          end

          it "returns a polite message" do
            subject.must_match /Boards not found./
          end
        end
      end
    end
  end
end
