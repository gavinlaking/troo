require_relative '../../../test_helper'

module Troo
  module External
    describe Resource do
      let(:described_class) { Resource }
      let(:external_id) { '526d8e130a14a9d846001d96' }
      let(:options) { {} }

      describe '.initialize' do
        subject { described_class.new(external_id, options) }

        it 'assigns the external_id to an instance variable' do
          subject.instance_variable_get('@external_id')
            .must_equal(external_id)
        end

        it 'assigns the options to an instance variable' do
          subject.instance_variable_get('@options')
            .must_equal(options)
        end
      end
    end
  end
end
