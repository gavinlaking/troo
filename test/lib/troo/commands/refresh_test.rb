require_relative '../../../test_helper'

module Troo
  module Commands
    describe Refresh do
      let(:described_class) { Refresh }
      let(:klass) { stub(type: 'resource_type', remote: stub) }
      let(:id) {}
      let(:resource) {}
      let(:retrieved) {}

      before do
        API::Client.stubs(:perform)
        @board = Fabricate.build(:board)
        Retrieval::Local.stubs(:retrieve).returns(resource)
        Retrieval::Remote.stubs(:fetch).returns(retrieved)
      end

      after { database_cleanup }

      describe '#initialize' do
        subject { described_class.new(klass, id) }

        it 'assigns the klass to an instance variable' do
          subject.instance_variable_get('@klass').must_equal(klass)
        end

        it 'assigns the id to an instance variable' do
          subject.instance_variable_get('@id').must_equal(id)
        end
      end

      describe '.dispatch' do
        subject { described_class.dispatch(klass, id) }

        context 'when the resource exists' do
          let(:resource) { @board }
          let(:retrieved) { [@board] }

          context 'and the resource is refreshed' do
            it 'returns a polite message' do
              subject.must_match(/refreshed/)
            end
          end

          context 'and multiple resources are refreshed' do
            let(:retrieved) { [@board, @board] }

            it 'returns a polite message' do
              subject.must_match(/Multiple/)
            end
          end
        end

        context 'when the resource does not exist' do
          let(:resource) {}

          it 'returns a polite message' do
            subject.must_match(/cannot be found/)
          end
        end

        context 'and the default resource does not exist' do
          let(:id) {}
          let(:resource) {}

          it 'returns a polite message' do
            subject.must_match(/to set a default/)
          end
        end
      end
    end
  end
end
