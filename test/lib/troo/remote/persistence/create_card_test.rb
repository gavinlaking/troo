require_relative '../../../../test_helper'

module Troo
  describe CreateCard do
    let(:described_class)  { CreateCard }
    let(:external_list_id) { '526d8e130a14a9d846001d97' }
    let(:resource_name)    { 'My New Card' }
    let(:description)      { 'A description to get us started.' }
    let(:card) do
      [Fabricate.build(:card, name: resource_name, desc: description)]
    end

    before { Persistence::Resource.stubs(:with_collection).returns(card) }
    after  { database_cleanup }

    describe '.initialize' do
      subject do
        described_class
          .new(external_list_id, resource_name, description)
      end

      it 'assigns the external_list_id to an instance variable' do
        subject.instance_variable_get('@external_list_id')
          .must_equal(external_list_id)
      end

      it 'assigns the name to an instance variable' do
        subject.instance_variable_get('@name')
          .must_equal(resource_name)
      end

      it 'assigns the description to an instance variable' do
        subject.instance_variable_get('@description')
          .must_equal(description)
      end
    end

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
