require_relative '../../../test_helper'

module Troo
  describe MoveCard do
    let(:described_class) { MoveCard }

    before do
      @list = Fabricate(:list, external_list_id: '526d8e130a14a9d846001d98')
      @card = Fabricate(:card)
      Troo::External::Card.stubs(:fetch).returns(true)
     end

    after { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(@card, @list) }

      it 'assigns the card to an instance variable' do
        subject.instance_variable_get('@card').must_equal(@card)
      end

      it 'assigns the list to an instance variable' do
        subject.instance_variable_get('@list').must_equal(@list)
      end
    end

    describe '#perform' do
      before { VCR.insert_cassette(:move_card, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.with(@card, @list) }

      context 'when the card was moved' do
        it 'returns a refresh of all cards for the board' do
          subject.wont_equal false
        end
      end

      context 'when the card was not moved' do
        before { Trello::Card.any_instance.stubs(:move_to_list).raises(Trello::Error) }

        it { subject.must_equal false }
      end
    end
  end
end
