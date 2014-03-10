require_relative '../../../test_helper'

module Troo
  module Remote
    describe List do
      def load_mock_trello_response
        json = File.read('./test/support/remotes/list.json')
        hash = Yajl::Parser.parse(json)
        Troo::Remote::List.new(hash)
      end

      let(:described_class) { List }
      let(:resource) { load_mock_trello_response }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:list)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:lists_by_board_id)
        end
      end

      describe '.by_list_id' do
        subject { described_class.by_list_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:list_by_id)
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::List }
      end

      describe '#adapted' do
        subject { described_instance.adapted }

        it 'returns an adapted resource for local persistence' do
          subject.must_equal(
            external_board_id: '526d8e130a14a9d846001d96',
            external_id:       '526d8e130a14a9d846001d97',
            name:              'My Test List',
            position:          32_768,
            closed:            false
          )
        end
      end
    end
  end
end
