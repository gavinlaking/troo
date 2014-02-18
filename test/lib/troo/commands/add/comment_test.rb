require_relative '../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Comment do
        let(:described_class) { Comment }
        let(:value) { 'Add Comment Test' }
        let(:id)    {}

        before do
          Retrieval::Card.stubs(:retrieve)
          CreateComment.stubs(:for).returns(false)
          API::Client.stubs(:perform)
        end

        describe '#add' do
          subject { described_class.new(value, id).add }

          context 'when the parent resource exists' do
            context 'and the comment was created' do
              before { CreateComment.stubs(:for).returns(true) }

              it 'returns a polite message' do
                subject.must_match(/New comment created/)
              end
            end

            context 'and the comment was not created' do
              it 'returns a polite message' do
                subject.must_match(/could not/)
              end
            end
          end

          context 'when the parent resource does not exist' do
            it 'returns a polite message' do
              subject.must_match(/could not/)
            end
          end
        end
      end
    end
  end
end
