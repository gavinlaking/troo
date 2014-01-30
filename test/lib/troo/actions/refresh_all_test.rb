require_relative "../../../test_helper"

module Troo
  module CLI
    module Commands
      describe RefreshAll do
        let(:described_class) { RefreshAll }
        let(:options) { { } }

        before do
          @board = Fabricate(:board)
          @list = Fabricate(:list)
          @card = Fabricate(:card)

          External::Board.stubs(:fetch_all).returns([@board])
          External::List.stubs(:fetch).returns([@list])
          External::Card.stubs(:fetch).returns([@card])
          External::Comment.stubs(:fetch).returns([])
          External::Member.stubs(:fetch).returns([])
        end

        after { database_cleanup }

        describe ".dispatch" do
          let(:board) { nil }

          subject { described_class.dispatch }

          it "returns a polite message" do
            subject.must_equal("All local data refreshed.")
          end
        end
      end
    end
  end
end
