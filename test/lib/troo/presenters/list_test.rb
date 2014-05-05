require_relative '../../../test_helper'

module Troo
  module Presenters
    describe List do
      let(:described_class) { List }
      let(:list)            { Fabricate(:list) }
      let(:options)         { {} }

      let(:board)           { Fabricate(:board) }
      let(:card)            { Fabricate(:card) }
      let(:cards)           { [] }

      before do
        list.stubs(:board).returns(board)
        list.stubs(:cards).returns(cards)
      end

      after { database_cleanup }

      describe '#show' do
        subject do
          described_class.new(list, options).show
        end

        it 'renders the board title for the list' do
          subject.must_match(/My Test Board/)
        end

        it 'renders the list title' do
          subject.must_match(/My Test List/)
        end

        context 'when the list has cards' do
          let(:cards) { [card] }

          it 'renders the view' do
            subject.must_match(/My Test Card/)
          end
        end

        context 'when the list has no cards' do
          it 'returns a polite message' do
            subject.must_match(/No cards were found./)
          end
        end
      end
    end
  end
end
