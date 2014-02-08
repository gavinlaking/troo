require_relative '../../../test_helper'

module Troo
  describe List do
    let(:described_class) { List }
    let(:described_instance) { Fabricate.build(:list) }

    subject { described_instance }

    context 'attributes' do
      it 'should have a name attribute' do
        subject.name.must_equal 'My Test List'
      end

      it 'should have a position attribute' do
        subject.position.must_equal 32_768
      end

      it 'should have a default attribute' do
        subject.default.must_equal false
      end

      it 'should have a closed attribute' do
        subject.closed.must_equal false
      end

      it 'should have a external_board_id attribute' do
        subject.external_board_id.must_equal '526d8e130a14a9d846001d96'
      end

      it 'should have an external_list_id attribute' do
        subject.external_list_id.must_equal '526d8e130a14a9d846001d97'
      end
    end

    context 'associations' do
      before do
        @board = Fabricate(:board)
        @card  = Fabricate(:card)
      end

      after { database_cleanup }

      it 'belongs to a board' do
        subject.board.must_equal @board
      end

      it 'can have many cards' do
        subject.cards.size.must_equal 1
      end
    end
  end
end
