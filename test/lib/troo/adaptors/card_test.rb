require_relative '../../../test_helper'

module Troo
  describe Adaptors::Card do
    def load_mock_trello_response
      json = File.read('./test/support/remotes/card.json')
      hash = Yajl::Parser.parse(json)
      Troo::Remote::Card.new(hash)
    end

    let(:described_class) { Adaptors::Card }
    let(:resource) { load_mock_trello_response }

    describe '#adapted' do
      subject { described_class.adapt(resource) }

      it 'returns an adapted resource for local persistence' do
        subject.must_equal(
          external_board_id:   '526d8e130a14a9d846001d96',
          external_list_id:    '526d8e130a14a9d846001d98',
          external_card_id:    '526d8f19ddb279532e005259',
          external_member_ids: ['5195fdb5a8c01a2318004f5d'],
          short_id:            67,
          name:                'My Test Card',
          desc:                'some description',
          url:                 '<Trello URL>',
          position:            589823,
          last_activity_date:  '2014-02-13T20:12:46.612Z',
          closed:              false)
      end
    end
  end
end
