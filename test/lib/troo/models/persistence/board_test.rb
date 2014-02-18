require_relative '../../../../test_helper'

module Troo
  describe Persistence::Board do
    let(:described_class) { Persistence::Board }
    let(:resource) do
      [Remote::Board.new(
        id:             '526d8e130a14a9d846001d96',
        name:           'My Test Board',
        description:    'A very brief description...',
        closed:         false)]
    end
    let(:options) { {} }
    let(:klass) { Troo::Board }

    describe '#persist' do
      subject { described_class.with_collection(resource, options) }

      context 'when the local exists' do
        let(:default) { false }

        before { @board = Fabricate(:board, default: default) }
        after  { database_cleanup }

        context 'and the local is default' do
          let(:default) { true }

          it 'the remote is set to default' do
            subject.first.default.must_equal(true)
          end
        end

        context 'and the local is not default' do
          it 'the remote is not set to default' do
            subject.first.default.must_equal(false)
          end
        end

        it 'deletes the local and persists the remote' do
          @board.delete
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
