require_relative '../../../../test_helper'

module Troo
  module Commands
    describe Refresh do
      let(:described_class) { Refresh }
      let(:id)              {}
      let(:resource)        {}
      let(:retrieved)       {}
      let(:klass)           {
        stub(type: :resource_type, remote: stub)
      }

      before do
        API::Client.stubs(:perform)
        @board = Fabricate.build(:board)
        Retrieval::Local.stubs(:retrieve).returns(resource)
        Retrieval::Remote.stubs(:fetch).returns(retrieved)
      end

      after { database_cleanup }

      describe '.dispatch' do
        subject { described_class.dispatch(klass, id) }

        context 'when the resource exists' do
          let(:resource)  { @board }
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
          it 'returns a polite message' do
            subject.must_match(/cannot be found/)
          end
        end

        context 'and the default resource does not exist' do
          it 'returns a polite message' do
            subject.must_match(/to set a default/)
          end
        end
      end
    end
  end
end
