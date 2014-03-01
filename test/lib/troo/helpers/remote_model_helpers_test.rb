require_relative '../../../test_helper'

class RemoteModelHelpersDummy
  include Troo::RemoteModelHelpers

  def initialize(hash)
    @hash = hash
  end
end

module Troo
  describe RemoteModelHelpersDummy do
    let(:described_class) { RemoteModelHelpersDummy }
    let(:resources) { [{}, {}] }

    describe '.with_collection' do
      subject { described_class.with_collection(resources) }

      it 'instantiates classes' do
        subject.first.must_be_instance_of(RemoteModelHelpersDummy)
      end

      it 'returns a collection of instantiated classes' do
        subject.size.must_equal(2)
      end
    end

    describe '.all' do
      subject { described_class.all }

      it 'returns the resource parameters' do
        subject.must_equal({})
      end
    end

    describe '.by_board_id' do
      subject { described_class.by_board_id }

      it 'returns the resource parameters' do
        subject.must_equal({})
      end
    end

    describe '.by_list_id' do
      subject { described_class.by_list_id }

      it 'returns the resource parameters' do
        subject.must_equal({})
      end
    end

    describe '.by_card_id' do
      subject { described_class.by_card_id }

      it 'returns the resource parameters' do
        subject.must_equal({})
      end
    end

    describe '.by_member_id' do
      subject { described_class.by_member_id }

      it 'returns the resource parameters' do
        subject.must_equal({})
      end
    end
  end
end
