require_relative '../../../test_helper'

module Troo
  describe CreateCard do
    let(:described_class) { CreateCard }
    let(:list_id)  { '526d8e130a14a9d846001d97' }
    let(:resource_name) { 'My New Card' }
    let(:description) { 'A description to get us started.' }

    before do
      API::Client.stubs(:perform)
      @list = Fabricate(:list)
      @card = Fabricate(:card, name: resource_name, desc: description)
      Persistence::Card.stubs(:for).returns(@card)
    end

    after { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(@list, resource_name, description) }

      it 'assigns the list to an instance variable' do
        subject.instance_variable_get('@list').must_equal(@list)
      end

      it 'assigns the name to an instance variable' do
        subject.instance_variable_get('@name').must_equal(resource_name)
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

      subject { described_class.with(@list, resource_name, description) }

      context 'when the card was created' do
        it 'returns the new card' do
          subject.must_equal(@card)
        end
      end

      context 'when the card was not created' do
        before { API::Client.stubs(:perform).returns(false) }

        it { subject.must_equal false }
      end
    end
  end
end
