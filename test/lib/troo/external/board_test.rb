require_relative '../../../test_helper'

module Troo
  module External
    describe Board do
      let(:described_class) { Board }
      let(:board_id)        { '526d8e130a14a9d846001d96' }
      let(:options)         { {} }

      describe '.fetch' do
        subject { described_class.fetch(board_id, options) }

        context 'when the all option is set' do
          let(:options) { { mode: :all } }

          before do
            VCR.insert_cassette(:boards_all,
                                decode_compressed_response: true)
          end
          after  { VCR.eject_cassette }

          it 'returns multiple boards' do
            subject.size.must_equal(1)
          end

          context 'when no boards can be found' do
            before { Trello::Board.stubs(:all).raises(Trello::Error) }

            it 'returns an empty collection' do
              subject.must_equal([])
            end
          end

          context 'and the option is :list' do
            let(:options) { { mode: :list } }

            it 'returns an empty collection' do
              subject.must_equal([])
            end
          end

          context 'and the option is :card' do
            let(:options) { { mode: :card } }

            it 'returns an empty collection' do
              subject.must_equal([])
            end
          end

          context 'and the option is :member' do
            let(:options) { { mode: :member } }

            it 'returns an empty collection' do
              subject.must_equal([])
            end
          end
        end

        context 'when the all option is not set' do
          before do
            VCR.insert_cassette(:board_by_id,
                                decode_compressed_response: true)
          end
          after  { VCR.eject_cassette }

          it 'returns a single board' do
            subject.size.must_equal(1)
          end

          it 'returns a board with the board_id' do
            subject.first.external_board_id.must_equal(board_id)
          end

          it 'returns a board with the correct name' do
            subject.first.name.must_equal('Troo App')
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
      end
    end
  end
end
