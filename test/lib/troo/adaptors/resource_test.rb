require_relative '../../../test_helper'

module Troo
  describe Adaptors::Board do
    let(:described_class) { Adaptors::Resource }
    let(:resource) {}

    describe '#initialize' do
      subject { described_class.new(resource) }

      it 'assigns the resource to an instance variable' do
        subject.instance_variable_get('@resource')
          .must_equal(resource)
      end
    end
  end
end
