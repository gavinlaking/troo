require_relative '../../../../test_helper'

module Troo
  module Commands
    describe RefreshAll do
      def load_mock_trello_response
        json = File.read('./test/support/remotes/board.json')
        hash = Yajl::Parser.parse(json)
        Troo::Remote::Board.new(hash)
      end
      let(:described_class) { RefreshAll }
      let(:resource) { [load_mock_trello_response] }

      before do
        Troo::Board.stubs(:fetch).returns(resource)
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
