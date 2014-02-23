require_relative '../../../../test_helper'

module Troo
  module Remote
    describe Board do
      let(:described_class)    { Board }
      let(:resource)           { {} }
      let(:described_instance) { described_class.new(resource) }

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [:lists, :cards, :members] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Board }
      end

      describe '#adaptor' do
        subject { described_instance.adaptor }

        it { subject.must_equal Adaptors::Board }
      end
    end
  end
end
