require_relative '../../../test_helper'

module Troo
  module Persistence
    describe Local do
      let(:described_class) { Local }
      let(:resources)       { [] }
      let(:resource)        { stub }

      before { resource.stubs(:preprocess).returns(resource) }

      describe '.with_collection' do
        subject { described_class.with_collection(resources) }

        it { subject.must_be_instance_of(Array) }

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
