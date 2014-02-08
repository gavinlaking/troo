require_relative '../../../../test_helper'

module Troo
  module Remote
    describe Comment do
      let(:described_class) { Comment }
      let(:json) do
        "{\"id\":\"52f51fb0b6e6b1fb2de2949e\"," \
        "\"idMemberCreator\":\"5195fdb5a8c01a2318004f5d\"," \
        "\"data\":{\"text\":\"This is a comment.\"," \
        "\"card\":{\"id\":\"526d8f19ddb279532e005259\"}," \
        "\"board\":{\"id\":\"526d8e130a14a9d846001d96\"}}," \
        "\"date\":\"2014-02-07T18:02:24.297Z\"}"
      end

      describe '#id' do
        subject { described_class.create(json).id }

        it 'returns the comment ID' do
          subject.must_equal('52f51fb0b6e6b1fb2de2949e')
        end
      end

      describe '#member_creator_id' do
        subject { described_class.create(json).member_creator_id }

        it 'returns the member creator ID' do
          subject.must_equal('5195fdb5a8c01a2318004f5d')
        end
      end

      describe '#date' do
        subject { described_class.create(json).date }

        it 'returns the date the comment was created' do
          subject.must_equal('2014-02-07T18:02:24.297Z')
        end
      end

      describe '#data' do
        subject { described_class.create(json).data }

        it 'returns a hash of useful data' do
          subject.must_equal(
            'text' => 'This is a comment.',
            'card' => {
              'id' => '526d8f19ddb279532e005259'
            },
            'board' => {
              'id' => '526d8e130a14a9d846001d96'
            })
        end
      end
    end
  end
end
