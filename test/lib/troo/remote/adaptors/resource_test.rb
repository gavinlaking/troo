require_relative '../../../../test_helper'

module Troo
  module Remote
    module Adaptors
      describe Resource do
        let(:described_class) { Resource }
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
  end
end
