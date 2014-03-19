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
        subject.external_board_id.must_equal '20010'
      end

      it 'should have an external_card_id attribute' do
        subject.external_card_id.must_equal '20020'
      end

      it 'should have an external_id attribute' do
        subject.external_id.must_equal '20030'
      end

      it 'should have a external_member_id attribute' do
        subject.external_member_id.must_equal '20050'
      end

      it 'should always respond false to default?' do
        subject.default?.must_equal false
      end
    end

    describe '.remote' do
      subject { described_class.remote }

      it 'returns the remote class for this model' do
        subject.must_equal(Remote::Comment)
      end
    end

    describe '.type' do
      subject { described_class.type }

      it 'returns the type of model' do
        subject.must_equal(:comments)
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

    describe '#decorator' do
      let(:options) { {} }

      subject { described_class.new.decorator(options) }

      it 'returns a new instance of the decorator for this model' do
        subject.must_be_instance_of(Decorators::Resource)
      end
    end

    describe '#default?' do
      subject { described_class.new.default? }

      it { subject.must_equal false }
    end

    describe '#type' do
      subject { described_class.new.type }

      it 'returns the type of the model instance' do
        subject.must_equal(:comments)
      end
    end
  end
end
