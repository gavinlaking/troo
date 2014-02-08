require_relative '../../../test_helper'

module Troo
  describe Adaptors::Comment do
    let(:described_class) { Adaptors::Comment }
    let(:resource) do OpenStruct.new(
      id:                '51f9277b2822b8654f0023af',
      member_creator_id: '5195fdb5a8c01a2318004f5d',
      date:              '2013-12-17 22:01:13 UTC',
      data: {
        'text'  => 'My Test Comment',
        'board' => { 'id' => '526d8e130a14a9d846001d96' },
        'card'  => { 'id' => '526d8f19ddb279532e005259' } })
    end

    describe '#initialize' do
      subject { described_class.new(resource) }

      it 'assigns the resource to an instance variable' do
        subject.instance_variable_get('@resource').must_equal(resource)
      end
    end

    describe '#adapted' do
      subject { described_class.adapt(resource) }

      it 'returns an adapted resource suitable for local persistence' do
        subject.must_equal(
          external_comment_id: '51f9277b2822b8654f0023af',
          external_board_id:   '526d8e130a14a9d846001d96',
          external_card_id:    '526d8f19ddb279532e005259',
          external_member_id:  '5195fdb5a8c01a2318004f5d',
          date:                '2013-12-17 22:01:13 UTC',
          text:                'My Test Comment'
        )
      end
    end
  end
end
