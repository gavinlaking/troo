require_relative '../../../test_helper'

module Troo
  describe Comment do
    let(:described_class) { Comment }
    let(:described_instance) { Fabricate.build(:comment) }

    subject { described_instance }

    context 'attributes' do
      it 'should have a text attribute' do
        subject.text.must_equal 'My Test Comment'
      end

      it 'should have a date attribute' do
        subject.date.must_equal '2013-12-17 22:01:13 UTC'
      end

      it 'should have an external_board_id attribute' do
        subject.external_board_id.must_equal '526d8e130a14a9d846001d96'
      end

      it 'should have an external_card_id attribute' do
        subject.external_card_id.must_equal '526d8f19ddb279532e005259'
      end

      it 'should have an external_comment_id attribute' do
        subject.external_comment_id.must_equal '51f9277b2822b8654f0023af'
      end

      it 'should have a external_member_id attribute' do
        subject.external_member_id.must_equal '5195fdb5a8c01a2318004f5d'
      end

      it 'should always respond false to default?' do
        subject.default?.must_equal false
      end
    end

    context 'associations' do
      before do
        @board  = Fabricate(:board)
        @card   = Fabricate(:card)
        @member = Fabricate(:member)
      end

      after { database_cleanup }

      it 'belongs to a board' do
        subject.board.must_equal @board
      end

      it 'belongs to a card' do
        subject.card.must_equal @card
      end

      it 'belongs to a member' do
        subject.member.must_equal @member
      end
    end
  end
end
