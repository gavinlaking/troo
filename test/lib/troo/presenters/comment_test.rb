require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Comment do
      let(:described_class) { Comment }
      let(:card)            { Fabricate(:card) }
      let(:options)         { {} }

      let(:comments)        { [] }
      let(:comment)         { Fabricate(:comment) }
      let(:decorator)       { stub }
      let(:output)          { '' }

      before do
        card.stubs(:comments).returns(comments)
        comment.stubs(:decorator).returns(decorator)
        decorator.stubs(:as_view).returns(output)
      end

      after { database_cleanup }

      describe '#show' do
        subject do
          capture_io { described_class.new(card, options).show }.join
        end

        it 'renders the card title' do
          subject.must_match(/My Test Card/)
        end

        context 'when the card has comments' do
          let(:comments) { [comment] }
          let(:output)   { 'My Test Comment' }

          it 'renders the comments' do
            subject.must_match(/My Test Comment/)
          end
        end

        context 'when the card has no comments' do
          it 'returns a polite message' do
            subject.must_match(/No comments were found/)
          end
        end
      end
    end
  end
end
