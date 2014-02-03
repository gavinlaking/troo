require_relative "../../../../test_helper"

module Troo
  module Commands
    module Refresh
      describe All do
        let(:described_class) { All }

        before do
          @board = Fabricate(:board)
          @list  = Fabricate(:list)
          @card  = Fabricate(:card)

          External::Board.stubs(:fetch).returns([@board])
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
