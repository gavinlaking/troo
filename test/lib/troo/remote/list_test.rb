require_relative '../../../test_helper'

module Troo
  module Remote
    describe List do
      let(:described_class)    { List }
      let(:resource)           { {} }
      let(:described_instance) { described_class.new(resource) }

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::List }
      end

      describe '#adaptor' do
        subject { described_instance.adaptor }

        it { subject.must_equal Adaptors::List }
      end
    end
  end
end
