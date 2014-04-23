require_relative '../../../test_helper'

module Troo
  describe Board do
    let(:described_class) { Board }
    let(:described_instance) { Fabricate.build(:board) }

    subject { described_instance }

    context 'attributes' do
      it 'should have a name attribute' do
        subject.name.must_equal 'My Test Board'
      end

      it 'should have a description attribute' do
        subject.description.must_equal 'A very brief description...'
      end

      it 'should have a default attribute' do
        subject.default.must_equal false
      end

      it 'should have a closed attribute' do
        subject.closed.must_equal false
      end

      it 'should have an external_id attribute' do
        subject.external_id.must_equal '20010'
      end
    end

    describe '.remote' do
      subject { described_class.remote }

      it 'returns the remote class for this model' do
        subject.must_equal(Remote::Board)
      end
    end

    describe '.type' do
      subject { described_class.type }

      it { subject.must_be_instance_of(Symbol) }

      it 'returns the type of model' do
        subject.must_equal(:board)
      end
    end

    context 'associations' do
      before do
        @list  = Fabricate(:list)
        @card  = Fabricate(:card)
      end

      after { database_cleanup }

      it 'can have many lists' do
        subject.lists.size.must_equal 1
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
        subject.must_be_instance_of(Presenters::Board)
      end
    end

    describe '#type' do
      subject { described_class.new.type }

      it 'returns the type of the model instance' do
        subject.must_equal(:board)
      end
    end
  end
end
