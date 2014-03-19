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
        subject.external_board_id.must_equal '20010'
      end

      it 'should have an external_id attribute' do
        subject.external_id.must_equal '20040'
      end
    end

    describe '.remote' do
      subject { described_class.remote }

      it 'returns the remote class for this model' do
        subject.must_equal(Remote::List)
      end
    end

    describe '.type' do
      subject { described_class.type }

      it 'returns the type of model' do
        subject.must_equal(:list)
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

    describe '#decorator' do
      let(:options) { {} }

      subject { described_class.new.decorator(options) }

      it 'returns a new instance of the decorator for this model' do
        subject.must_be_instance_of(Decorators::Resource)
      end
    end

    describe '#presenter' do
      let(:options) { {} }

      subject { described_class.new.presenter(options) }

      it 'returns a new instance of the presenter for this model' do
        subject.must_be_instance_of(Presenters::List)
      end
    end

    describe '#type' do
      subject { described_class.new.type }

      it 'returns the type of the model instance' do
        subject.must_equal(:list)
      end
    end
  end
end
