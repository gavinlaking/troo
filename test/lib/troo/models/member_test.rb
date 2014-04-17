require_relative '../../../test_helper'

module Troo
  describe Member do
    let(:described_class) { Member }
    let(:described_instance) { Fabricate.build(:member) }

    subject { described_instance }

    context 'attributes' do
      it 'should have a username attribute' do
        subject.username.must_equal 'gavinlaking1'
      end

      it 'should have an email attribute' do
        subject.email.must_equal 'gavinlaking@gmail.com'
      end

      it 'should have a full_name attribute' do
        subject.full_name.must_equal 'Gavin Laking'
      end

      it 'should have an initials attribute' do
        subject.initials.must_equal 'GL'
      end

      it 'should have an avatar_id attribute' do
        subject.avatar_id.must_equal 'some_avatar_id'
      end

      it 'should have a bio attribute' do
        subject.bio.must_equal 'some bio'
      end

      it 'should have a url attribute' do
        subject.url.must_equal 'http://www.gavinlaking.name/'
      end

      it 'should have an external_id attribute' do
        subject.external_id.must_equal '20050'
      end

      it 'should always respond false to default?' do
        subject.default?.must_equal false
      end
    end

    describe '.remote' do
      subject { described_class.remote }

      it 'returns the remote class for this model' do
        subject.must_equal(Remote::Member)
      end
    end

    describe '.type' do
      subject { described_class.type }

      it 'returns the type of model' do
        subject.must_equal(:member)
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
        subject.must_be_instance_of(Presenters::Member)
      end
    end

    describe '#default?' do
      subject { described_class.new.default? }

      it { subject.must_equal false }
    end

    describe '#type' do
      subject { described_class.new.type }

      it 'returns the type of the model instance' do
        subject.must_equal(:member)
      end
    end
  end
end
