require_relative '../../../../test_helper'

module Troo
  module Commands
    module Refresh
      describe All do
        let(:described_class) { All }

        before do
          @board = Fabricate.build(:board)
          @list  = Fabricate.build(:list)
          @card  = Fabricate.build(:card)

          Board.stubs(:remote).returns([@board])
          List.stubs(:remote).returns([@list])
          Card.stubs(:remote).returns([@card])
          Comment.stubs(:remote).returns([])
          Member.stubs(:remote).returns([])
        end

        describe '.dispatch' do
          subject { described_class.dispatch }

          context 'when all the resources are refreshed' do
            it 'returns a polite message' do
              subject.must_match(/All local data refreshed/)
            end
          end

          context 'when all the resources are not refreshed' do
            it 'returns a polite message' do
              skip('Not implemented yet.')
            end
          end
        end
      end
    end
  end
end
