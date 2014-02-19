require_relative '../../../test_helper'

module Troo
  describe Adaptors::Member do
    def load_mock_trello_response
      json = File.read('./test/support/remotes/member.json')
      hash = Yajl::Parser.parse(json)
      Troo::Remote::Member.new(hash)
    end

    let(:described_class) { Adaptors::Member }
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
          external_member_id: '5195fdb5a8c01a2318004f5d',
          username:           'gavinlaking1',
          email:              'gavinlaking@gmail.com',
          full_name:          'Gavin Laking',
          initials:           'GL',
          avatar_id:          '045fd924d84699c9ba451e181bba33a3',
          bio:                'some bio',
          url:                '<Trello URL>'
        )
      end
    end
  end
end
