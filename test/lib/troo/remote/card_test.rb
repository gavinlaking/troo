require_relative '../../../test_helper'

module Troo
  module Remote
    describe Card do
      let(:described_class) { Card }
      let(:resource)        {
        mock_trello_response('card.json', Troo::Remote::Card)
      }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:card)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:cards_by_board_id)
        end
      end

      describe '.by_list_id' do
        subject { described_class.by_list_id }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:cards_by_list_id)
        end
      end

      describe '.by_card_id' do
        subject { described_class.by_card_id }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:card_by_id)
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_be_instance_of(Array) }

        it { subject.must_equal [:actions] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_be_instance_of(Class) }

        it { subject.must_equal Troo::Card }
      end

      describe '#adapted' do
        subject { described_instance.adapted }

        it { subject.must_be_instance_of(Hash) }

        it 'returns an adapted resource for local persistence' do
          subject.must_equal(
            external_board_id:   '20010',
            external_list_id:    '20040',
            external_id:         '20020',
            external_member_ids: ['20050'],
            short_id:            67,
            name:                'My Test Card',
            desc:                'some description',
            url:                 '<Trello URL>',
            position:            589_823,
            last_activity_date:  '2014-02-13T20:12:46.612Z',
            closed:              false
          )
        end
      end
    end
  end
end
