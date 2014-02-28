require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe List do
        let(:described_class)   { List }
        let(:external_board_id) { '526d8e130a14a9d846001d96' }
        let(:resource_name)     { 'My New List' }
        let(:list) do
          [Fabricate.build(:list, name: resource_name)]
        end

        before do
          Troo::Persistence::Resource.stubs(:with_collection)
            .returns(list)
        end
        after  { database_cleanup }

        describe '.initialize' do
          subject do
            described_class.new(external_board_id, resource_name)
          end

          it 'assigns the external_board_id to an instance variable' do
            subject.instance_variable_get('@external_board_id')
              .must_equal(external_board_id)
          end

          it 'assigns the name to an instance variable' do
            subject.instance_variable_get('@name')
              .must_equal(resource_name)
          end
        end

        describe '.with' do
          before do
            VCR.insert_cassette(:create_list,
                                decode_compressed_response: true)
          end

          after  { VCR.eject_cassette }

          subject { described_class.with(@board, resource_name) }

          context 'when the list was created' do
            it 'returns the new list' do
              subject.must_be_instance_of Troo::List
            end
          end

          context 'when the list was not created' do
            before { API::Client.stubs(:perform).returns([]) }

            it { subject.must_equal false }
          end
        end
      end
    end
  end
end
