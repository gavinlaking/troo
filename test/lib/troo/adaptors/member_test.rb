require_relative '../../../test_helper'

module Troo
  describe Adaptors::Member do
    let(:described_class) { Adaptors::Member }
    let(:resource) do
      OpenStruct.new(
        id:        '5195fdb5a8c01a2318004f5d',
        username:  'gavinlaking1',
        email:     'gavinlaking@gmail.com',
        full_name: 'Gavin Laking',
        initials:  'GL',
        avatar_id: 'some_avatar_id',
        bio:       'some bio',
        url:       'http://www.gavinlaking.name/')
    end

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
          external_member_id: '5195fdb5a8c01a2318004f5d',
          username:           'gavinlaking1',
          email:              'gavinlaking@gmail.com',
          full_name:          'Gavin Laking',
          initials:           'GL',
          avatar_id:          'some_avatar_id',
          bio:                'some bio',
          url:                'http://www.gavinlaking.name/'
        )
      end
    end
  end
end
