require_relative '../../../../test_helper'

module Troo
  describe Persistence::Comment do
    def load_mock_trello_response
      json = File.read('./test/support/remotes/comment.json')
      hash = Yajl::Parser.parse(json)
      Troo::Remote::Comment.new(hash)
    end

    let(:described_class) { Persistence::Comment }
    let(:resource) { [load_mock_trello_response] }
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
