require_relative '../../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Comment do
        let(:described_class) { Comment }
        let(:value)           { 'Add Comment Test' }
        let(:id)              {}
        let(:options)         { { type: :comment } }
        let(:outcome)         { false }

        before do
          API::Client.stubs(:perform)
          Troo::Card.stubs(:retrieve).returns(resource)
          Remote::Persistence::Comment.stubs(:with).returns(outcome)
        end

        describe '#add' do
          subject { described_class.new(value, id, options).add }

          context 'when the parent resource exists' do
            let(:resource) { Troo::Card.new }

            context 'and the comment was created' do
              let(:outcome) { true }

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
            let(:resource) {}

            it 'returns a polite message' do
              subject.must_match(/could not/)
            end
          end
        end
      end
    end
  end
end
