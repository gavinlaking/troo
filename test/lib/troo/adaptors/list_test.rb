require_relative '../../../test_helper'

module Troo
  describe Adaptors::List do
    def load_mock_trello_response
      json = File.read('./test/support/remotes/list.json')
      hash = Yajl::Parser.parse(json)
      Troo::Remote::List.new(hash)
    end

    let(:described_class) { Adaptors::List }
    let(:resource) { load_mock_trello_response }

    describe '#adapted' do
      subject { described_class.adapt(resource) }

      it 'returns an adapted resource for local persistence' do
        subject.must_equal(
          external_board_id: '526d8e130a14a9d846001d96',
          external_list_id:  '526d8e130a14a9d846001d97',
          name:              'My Test List',
          position:          32_768,
          closed:            false
        )
      end
    end
  end
end
