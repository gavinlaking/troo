require_relative '../../../../../test_helper'

module Troo
  module Commands
    describe RefreshAll do
      let(:described_class) { RefreshAll }
      let(:resource) do
        [mock_trello_response('board.json', Troo::Remote::Board)]
      end

      before do
        Retrieval::Remote.stubs(:fetch).returns(resource)
      end

      describe '.dispatch' do
        subject { described_class.dispatch }

        context 'when all the resources are refreshed' do
          it 'returns a polite message' do
            subject.must_match(/All local data refreshed/)
          end
        end

        context 'when all the resources are not refreshed' do
          let(:resource) { [] }

          it 'returns a polite message' do
            subject.must_match(/Cannot refresh all local data/)
          end
        end
      end
    end
  end
end
