require_relative '../../../test_helper'

module Troo
  module Persistence
    describe Local do
      let(:described_class) { Local }
      let(:resources)       { [] }
      let(:resource)        { stub }

      before { resource.stubs(:preprocess).returns(resource) }

      describe '.initialize' do
        subject { described_class.new(resource) }

        it 'assigns the resource to an instance variable' do
          subject.instance_variable_get('@resource')
            .must_equal(resource)
        end
      end

      describe '.with_collection' do
        subject { described_class.with_collection(resources) }

        context 'when the collection is empty' do
          it 'returns the empty collection' do
            subject.must_equal []
          end
        end

        context 'when the collection is not empty' do
          let(:resources) { [resource] }

          it 'returns the last persisted resource' do
            subject.must_equal [resource]
          end
        end
      end
    end
  end
end
