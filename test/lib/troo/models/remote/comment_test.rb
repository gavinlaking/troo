require_relative '../../../../test_helper'

module Troo
  module Remote
    describe Comment do
      let(:described_class) { Comment }
      let(:resource) do
        {
          'id' => '52f51fb0b6e6b1fb2de2949e',
          'idMemberCreator' => '5195fdb5a8c01a2318004f5d',
          'data' => {
            'text' => 'This is a comment.',
            'card' => {
              'id' => '526d8f19ddb279532e005259'
            },
            'board' => {
              'id' => '526d8e130a14a9d846001d96'
            }
          },
          'date' => '2014-02-07T18:02:24.297Z',
          'memberCreator' => ''
        }
      end

      describe '#external_board_id' do
        subject { described_class.new(resource).external_board_id }

        it 'delegates to the CommentData model' do
          subject.must_equal('526d8e130a14a9d846001d96')
        end
      end

      describe '#external_card_id' do
        subject { described_class.new(resource).external_card_id }

        it 'delegates to the CommentData model' do
          subject.must_equal('526d8f19ddb279532e005259')
        end
      end

      describe '#external_comment_id' do
        subject { described_class.new(resource).external_comment_id }

        it 'returns the value of the id attribute' do
          subject.must_equal('52f51fb0b6e6b1fb2de2949e')
        end
      end

      describe '#id_member_creator' do
        subject { described_class.new(resource).id_member_creator }

        it 'delegates to the idMemberCreator attribute' do
          subject.must_equal('5195fdb5a8c01a2318004f5d')
        end
      end

      describe '#text' do
        subject { described_class.new(resource).text }

        it 'delegates to the CommentData model' do
          subject.must_equal('This is a comment.')
        end
      end

      describe '#member_creator' do
        subject { described_class.new(resource).member_creator }

        it 'delegates to the memberCreator attribute' do
          subject.must_equal('')
        end
      end
    end
  end
end
