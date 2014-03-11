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
  end
end
