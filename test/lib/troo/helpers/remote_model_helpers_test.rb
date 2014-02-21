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
  end
end
