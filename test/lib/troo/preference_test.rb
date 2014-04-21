require_relative '../../test_helper'

module Troo
  describe Preference do
    let(:described_class) { Preference }
    let(:parameters)      {
      {
        label: 'my_preference',
        value: 'Some value...'
      }
    }

    describe '#view' do
      subject { described_class.view(parameters) }

      it { subject.must_be_instance_of(String) }

      it 'presents the preference' do
        subject.must_equal('           my_preference: Some value...')
      end
    end
  end
end
