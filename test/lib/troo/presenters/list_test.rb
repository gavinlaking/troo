require_relative '../../../test_helper'

module Troo
  module Presenters
    describe List do
      let(:described_class) { List }
      let(:options) { {} }

      before do
        @list = Fabricate(:list)
        @board = Fabricate(:board)
        @card = Fabricate(:card)
      end

      after { database_cleanup }

      describe '#show' do
        subject { capture_io { described_class.show(@list, options) }.join }

        context 'when the list has cards' do
          it 'renders the view' do
            subject.must_match(/My Test Board/)
            subject.must_match(/My Test List/)
            subject.must_match(/My Test Card/)
          end
        end

        context 'when the list has no cards' do
          before { @card.delete }

          it 'returns a polite message' do
            subject.must_match(/No cards were found./)
          end
        end
      end
    end
  end
end
