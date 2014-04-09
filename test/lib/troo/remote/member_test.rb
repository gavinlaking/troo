require_relative '../../../test_helper'

module Troo
  module Remote
    describe Member do
      let(:described_class)    { Member }
      let(:resource)           {
        mock_trello_response('member.json', Troo::Remote::Member)
      }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:member)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:members_by_board_id)
        end
      end

      describe '.by_member_id' do
        subject { described_class.by_member_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:member_by_id)
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Member }
      end

      describe '#adapted' do
        subject { described_instance.adapted }

        it 'returns an adapted resource for local persistence' do
          subject.must_equal(
            external_id: '20050',
            username:    'gavinlaking1',
            email:       'gavinlaking@gmail.com',
            full_name:   'Gavin Laking',
            initials:    'GL',
            avatar_id:   '20001',
            bio:         'some bio',
            url:         '<Trello URL>'
          )
        end
      end
    end
  end
end
