require_relative '../../../test_helper'

module Troo
  module Remote
    describe Member do
      let(:described_class)    { Member }
      let(:resource)           { {} }
      let(:described_instance) { described_class.new(resource) }

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Member }
      end

      describe '#adaptor' do
        subject { described_instance.adaptor }

        it { subject.must_equal Adaptors::Member }
      end
    end
  end
end
