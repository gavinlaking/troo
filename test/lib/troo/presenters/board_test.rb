require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Board do
      let(:described_class) { Board }
      let(:board)           { Fabricate(:board) }
      let(:options)         { {} }

      let(:lists)           { [] }
      let(:list)            { Fabricate(:list) }
      let(:cards)           { [] }
      let(:card)            { Fabricate(:card) }

      before do
        board.stubs(:lists).returns(lists)
        list.stubs(:cards).returns(cards)
      end

      after { database_cleanup }

      describe '#show' do
        subject do
          capture_io { described_class.new(board, options).show }.join
        end

        it 'renders the view' do
          subject.must_match(/My Test Board/)
        end

        context 'when the board has lists' do
          let(:lists) { [list] }

          it 'renders the view' do
            subject.must_match(/My Test List/)
          end

          context 'and the list has cards' do
            let(:cards) { [card] }

            it 'renders the view' do
              subject.must_match(/My Test Card/)
            end
          end

          context 'and the list has no cards' do
            it 'returns a polite message' do
              subject.must_match(/No cards were found./)
            end
          end
        end

        context 'when the board has no lists' do
          it 'returns a polite message' do
            subject.must_match(/No lists were found./)
          end
        end
      end
    end
  end
end
