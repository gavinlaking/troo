require_relative '../../../../test_helper'

module Troo
  module Retrieval
    describe Resource do
      let(:described_class) { Resource }
      let(:id)              {}
      let(:options)         { {} }

      describe '#initialize' do
        subject { described_class.new(id, options) }

        it 'assigns the id to an instance variable' do
          subject.instance_variable_get('@id').must_equal(id)
        end

        it 'assigns the options to an instance variable' do
          subject.instance_variable_get('@options')
            .must_equal(options)
        end
      end
    end
  end
end
