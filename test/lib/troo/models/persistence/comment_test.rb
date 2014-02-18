require_relative '../../../../test_helper'

module Troo
  describe Persistence::Comment do
    let(:described_class) { Persistence::Comment }
    let(:resource) do
      [OpenStruct.new(
        id:   '51f9277b2822b8654f0023af',
        date: '2013-12-17 22:01:13 UTC',
        data: {
          'text' => 'My Test Comment',
          'board' => {
            'id' => '526d8e130a14a9d846001d96'
          },
          'card' => {
            'id' => '526d8f19ddb279532e005259'
        }
      })]
    end
    let(:options) { {} }
    let(:klass) { Troo::Comment }

    describe '#persist' do
      subject { described_class.with_collection(resource, options) }

      context 'when the local exists' do
        before { @comment = Fabricate(:comment) }
        after  { database_cleanup }

        it 'deletes the local and persists the remote' do
          @comment.delete
          subject
          klass.count.must_equal 1
        end
      end

      context 'when the local does not exist' do
        it 'persists the remote' do
          klass.count.must_equal 0
          subject
          klass.count.must_equal 1
        end
      end
    end
  end
end
