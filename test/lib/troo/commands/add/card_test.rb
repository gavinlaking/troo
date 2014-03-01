require_relative '../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Card do
        let(:described_class) { Card }
        let(:value)           { 'Add Card Test' }
        let(:id)              {}
        let(:outcome)         { false }

        before do
          Troo::List.stubs(:retrieve).returns(resource)
          Remote::Persistence::Card.stubs(:with).returns(outcome)
        end

        describe '#add' do
          subject { described_class.new(value, id).add }

          context 'when the parent resource exists' do
            let(:resource) { Troo::List.new }

            context 'and the card was created' do
              let(:outcome) { true }

              it 'returns a polite message' do
                subject.must_match(/\'Add Card Test\' created/)
              end
            end

            context 'and the card was not created' do
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
