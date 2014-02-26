require_relative '../../../test_helper'

module Troo
  describe MoveCard do
    let(:described_class) { MoveCard }
    let(:board_id) { '526d8e130a14a9d846001d97' }
    let(:list_id) { '526d8e130a14a9d846001d98' }

    before do
      @board = Fabricate(:board, external_board_id: board_id)
      @list = Fabricate(:list, external_list_id: list_id)
      @card = Fabricate(:card)
      Troo::External::Card.stubs(:fetch).returns(true)
    end

    after { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(@card, @list, @board) }

      it 'assigns the card to an instance variable' do
        subject.instance_variable_get('@card').must_equal(@card)
      end

      it 'assigns the list to an instance variable' do
        subject.instance_variable_get('@list').must_equal(@list)
      end

      it 'assigns the board to an instance variable' do
        subject.instance_variable_get('@board').must_equal(@board)
      end
    end

    describe '#perform' do
      subject { described_class.with(@card, @list, @board) }

      context 'when a board was not specified' do
        before do
          VCR.insert_cassette(:move_card,
                              decode_compressed_response: true)
        end

        after { VCR.eject_cassette }

        context 'and the card was moved' do
          it 'returns a refresh of all cards for the board' do
            subject.wont_equal false
          end
        end

        context 'and the card was not moved' do
          before do
            Trello::Card.any_instance.stubs(:move_to_list)
              .raises(Trello::Error)
          end

          it { subject.must_equal false }
        end
      end

      context 'when a board was specified' do
        before do
          VCR.insert_cassette(:move_card_to_board,
                              decode_compressed_response: true)
        end

        after { VCR.eject_cassette }

        context 'and the card was moved' do
          it 'returns a refresh of all cards for the board' do
            subject.wont_equal false
          end
        end

        context 'and the card was not moved' do
          before do
            Trello::Card.any_instance.stubs(:move_to_list)
              .raises(Trello::Error)
          end

          it { subject.must_equal false }
        end
      end
    end
  end
end
