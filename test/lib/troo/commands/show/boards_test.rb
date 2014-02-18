require_relative '../../../../test_helper'

module Troo
  module Commands
    module Show
      describe Boards do
        let(:described_class) { Boards }
        let(:resources) { [] }

        before do
          @board = Fabricate.build(:board)
          Troo::Board.stubs(:all).returns(resources)
          Presenters::Board.stubs(:all).returns(@board.name)
        end

        describe '.dispatch' do
          subject { described_class.dispatch }

          context 'when boards exist' do
            let(:resources) { [@board] }

            it 'presents the boards' do
              subject.must_match(/#{@board.name}/)
            end
          end

          context 'when no boards exist' do
            it 'returns a polite message' do
              subject.must_match(/Boards cannot be found/)
            end
          end
        end
      end
    end
  end
end
