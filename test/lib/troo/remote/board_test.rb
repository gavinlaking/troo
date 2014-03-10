require_relative '../../../test_helper'

module Troo
  module Remote
    describe Board do
      def load_mock_trello_response
        json = File.read('./test/support/remotes/board.json')
        hash = Yajl::Parser.parse(json)
        Troo::Remote::Board.new(hash)
      end

      let(:described_class) { Board }
      let(:resource) { load_mock_trello_response }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:board)
        end
      end

      describe '.all' do
        subject { described_class.all }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:boards_all)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:board_by_id)
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [:lists, :cards, :members] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Board }
      end

      describe '#adapted' do
        subject { described_instance.adapted }

        it 'returns an adapted resource for local persistence' do
          subject.must_equal(
            external_board_id: '526d8e130a14a9d846001d96',
            name:              'My Test Board',
            description:       'A very brief description...',
            closed:            false
          )
        end
      end
    end
  end
end
