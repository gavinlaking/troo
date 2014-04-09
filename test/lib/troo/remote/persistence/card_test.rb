require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe Card do
        let(:described_class)  { Card }
        let(:external_list_id) { '20040' }
        let(:resource_name)    { 'My New Card' }
        let(:description)      { 'A description to get us started.' }
        let(:card)             {
          [Fabricate.build(:card, name: resource_name,
                                  desc: description)]
        }

        before do
          Troo::Persistence::Local.stubs(:with_collection)
            .returns(card)
        end
        after  { database_cleanup }

        describe '.with' do
          before do
            VCR.insert_cassette(:create_card,
                                decode_compressed_response: true)
          end

          after  { VCR.eject_cassette }

          subject do
            described_class
              .with(external_list_id, resource_name, description)
          end

          context 'when the card was created' do
            it 'returns the new card' do
              subject.must_be_instance_of Troo::Card
            end
          end

          context 'when the card was not created' do
            before { API::Client.stubs(:perform).returns([]) }

            it { subject.must_equal false }
          end
        end
      end
    end
  end
end
