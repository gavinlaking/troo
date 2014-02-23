require_relative '../../../test_helper'

module Troo
  module Remote
    describe Card do
      let(:described_class)    { Card }
      let(:resource)           { {} }
      let(:described_instance) { described_class.new(resource) }

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Card }
      end

      describe '#adaptor' do
        subject { described_instance.adaptor }

        it { subject.must_equal Adaptors::Card }
      end
    end
  end
end
