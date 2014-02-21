require_relative '../../../test_helper'

module Troo
  describe Adaptors::Board do
    def load_mock_trello_response
      json = File.read('./test/support/remotes/board.json')
      hash = Yajl::Parser.parse(json)
      Troo::Remote::Board.new(hash)
    end

    let(:described_class) { Adaptors::Board }
    let(:resource) { load_mock_trello_response }

    describe '#adapted' do
      subject { described_class.adapt(resource) }

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
