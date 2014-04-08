require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Board do
      let(:described_class)    { Board }
      let(:described_instance) { described_class.new(board, options) }
      let(:board)              { Fabricate(:board) }
      let(:options)            { {} }

      before do
        Fabricate(:list)
        Fabricate(:card)
      end

      after { database_cleanup }

      describe '#show' do
        subject { described_instance.show }

        context 'when the board has lists' do
          it 'renders the view' do
            subject.must_match(/My Test List/)
          end
        end

        context 'when the board has no lists' do
          before { board.stubs(:lists).returns([]) }

          it 'returns a polite message' do
            subject.must_match(/No lists were found./)
          end
        end
      end
    end
  end
end
