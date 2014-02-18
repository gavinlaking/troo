require_relative '../../../../test_helper'

module Troo
  describe Persistence::Resource do
    let(:described_class) { Persistence::Resource }
    let(:resource) {}
    let(:options) { {} }

    describe '.initialize' do
      subject { described_class.new(resource, options) }

      it 'assigns the resource to an instance variable' do
        subject.instance_variable_get('@resource')
          .must_equal(resource)
      end

      it 'assigns the options to an instance variable' do
        subject.instance_variable_get('@options').must_equal(options)
      end
    end
  end
end
