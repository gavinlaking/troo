require_relative '../../../test_helper'

module Troo
  module External
    describe Card do
      let(:described_class) { Card }
      let(:card_id) { '526d8f19ddb279532e005259' }
      let(:options) { {} }

      before { @card = Fabricate(:card) }
      after  { database_cleanup }

      describe 'when the mode is board' do
        before do
          VCR.insert_cassette(:cards_by_board_id,
                              decode_compressed_response: true)
        end
        after  { VCR.eject_cassette }

        let(:board_id) { '526d8e130a14a9d846001d96' }
        let(:options)  { { mode: :board, comments: false } }

        subject { described_class.fetch(board_id, options) }

        it 'returns multiple cards' do
          subject.size.must_equal(2)
        end

        context 'when the board cannot be found' do
          before { Trello::Board.stubs(:find).raises(Trello::Error) }

          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end

        context 'when the access token is invalid' do
          before do
            Trello::Board.stubs(:find)
              .raises(Trello::InvalidAccessToken)
          end

          subject { described_class.new(board_id, options).fetch }

          it 'catches the exception and re-raises' do
            proc { subject }.must_raise(Troo::InvalidAccessToken)
          end
        end
      end

      describe 'when the mode is list' do
        before do
          VCR.insert_cassette(:cards_by_list_id,
                              decode_compressed_response: true)
        end
        after  { VCR.eject_cassette }

        let(:list_id) { '526d8e130a14a9d846001d97' }
        let(:options) { { mode: :list, comments: false } }

        subject { described_class.fetch(list_id, options) }

        it 'returns multiple cards' do
          subject.size.must_equal(1)
        end

        context 'when the list cannot be found' do
          before { Trello::List.stubs(:find).raises(Trello::Error) }

          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end
      end

      describe 'when the mode is card' do
        before do
          VCR.insert_cassette(:card_by_card_id,
                              decode_compressed_response: true)
        end
        after  { VCR.eject_cassette }

        let(:card_id) { '526d8f19ddb279532e005259' }
        let(:options) { { mode: :card, comments: false } }

        subject { described_class.fetch(card_id, options) }

        it 'returns a single card' do
          subject.size.must_equal(1)
        end

        context 'when the card cannot be found' do
          before { Trello::Card.stubs(:find).raises(Trello::Error) }

          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end
      end

      describe 'when the comments options is enabled' do
        before do
          Trello::Card.stubs(:find).returns(resource)
          External::Comment.stubs(:fetch)
        end

        let(:resource) do
          OpenStruct.new(id: '526d8f19ddb279532e005259')
        end
        let(:options) { { mode: :card, comments: true } }

        subject { described_class.fetch(card_id, options) }

        it 'fetches the comments for the card' do
          subject.size.must_equal(1)
        end
      end

      describe 'when the mode is member' do
        let(:member_id) { '5195fdb5a8c01a2318004f5d' }
        let(:options) { { mode: :member, comments: false } }

        subject { described_class.fetch(member_id, options) }

        it 'returns an empty collection' do
          subject.must_equal([])
        end
      end
    end
  end
end
