require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Comment do
      let(:described_class) { Comment }
      let(:card)            { Fabricate(:card) }
      let(:options)         { {} }

      before do
        Fabricate(:comment)
        Fabricate(:member)
      end

      after { database_cleanup }

      describe '#show' do
        subject do
          described_class.new(card, options).show
        end

        it 'renders the card title' do
          subject.must_match(/My Test Card/)
        end

        context 'when the card has comments' do
          it 'renders the comments' do
            subject.must_match(/My Test Comment/)
          end
        end

        context 'when the card has no comments' do
          before { card.stubs(:comments).returns([]) }

          it 'returns a polite message' do
            subject.must_match(/No comments were found/)
          end
        end
      end
    end
  end
end
