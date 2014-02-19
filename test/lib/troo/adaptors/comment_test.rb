require_relative '../../../test_helper'

module Troo
  describe Adaptors::Comment do
    def load_mock_trello_response
      json = File.read('./test/support/remotes/comment.json')
      hash = Yajl::Parser.parse(json)
      Troo::Remote::Comment.new(hash)
    end

    let(:described_class) { Adaptors::Comment }
    let(:resource) { load_mock_trello_response }

    describe '#initialize' do
      subject { described_class.new(resource) }

      it 'assigns the resource to an instance variable' do
        subject.instance_variable_get('@resource')
          .must_equal(resource)
      end
    end

    describe '#adapted' do
      subject { described_class.adapt(resource) }

      it 'returns an adapted resource for local persistence' do
        subject.must_equal(
          external_comment_id: '51f9277b2822b8654f0023af',
          external_board_id:   '526d8e130a14a9d846001d96',
          external_card_id:    '526d8f19ddb279532e005259',
          external_member_id:  '5195fdb5a8c01a2318004f5d',
          date:                '2014-02-07T18:02:24.297Z',
          text:                'My Test Comment'
        )
      end
    end
  end
end
