require_relative '../../../../test_helper'

module Troo
  module Commands
    module Refresh
      describe Board do
        let(:described_class) { Board }
        let(:id) { '1' }
        let(:resource) {}
        let(:retrieved) {}

        before do
          @board = Fabricate.build(:board)
          Retrieval::Board.stubs(:retrieve).returns(resource)
          External::Board.stubs(:fetch).returns(retrieved)
        end

        after { database_cleanup }

        describe '.dispatch' do
          subject { described_class.dispatch(id) }

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
              subject.must_match(/Board cannot be found/)
            end
          end

          context 'and the default resource does not exist' do
            let(:id) {}
            let(:resource) {}

            it 'returns a polite message' do
              subject.must_match(/Default board cannot be found/)
            end
          end
        end
      end
    end
  end
end
