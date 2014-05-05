require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe List do
        let(:described_class)   { List }
        let(:external_board_id) { '20010' }
        let(:resource_name)     { 'My New List' }
        let(:list)              {
          [Fabricate.build(:list, name: resource_name)]
        }

        before do
          Troo::Persistence::Local.stubs(:with_collection)
            .returns(list)
        end
        after  { database_cleanup }

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

            it { subject.must_be_instance_of(FalseClass) }

            it { subject.must_equal false }
          end
        end
      end
    end
  end
end
