require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Comment do
      let(:described_class) { Comment }
      let(:default) { true }
      let(:options) { {} }

      before do
        @comment = Fabricate(:comment)
        @member  = Fabricate(:member)
      end

      after { database_cleanup }

      describe '#as_view' do
        subject { described_class.new(@comment).as_view }

        it 'returns the rendered comment' do
          subject.must_match(/gavinlaking1/)
          subject.must_match(/My Test Comment/)
          subject.must_match(/Tue, Dec 17 at 22:01/)
        end
      end

      describe '#member_username' do
        subject { described_class.new(@comment).member_username }

        it 'returns the comment member username' do
          subject.must_equal(@comment.member.username + ':')
        end
      end

      describe '#text' do
        subject { described_class.new(@comment).text }

        it 'returns the comment text' do
          subject.must_equal(@comment.text)
        end
      end

      describe '#date' do
        subject { described_class.new(@comment).date }

        it 'returns the comment date' do
          subject.must_equal('Tue, Dec 17 at 22:01')
        end
      end
    end
  end
end
