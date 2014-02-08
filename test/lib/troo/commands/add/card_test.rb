require_relative '../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Card do
        let(:described_class) { Card }
        let(:value) { 'Add Card Test' }
        let(:id)    {}

        before do
          Retrieval::List.stubs(:retrieve)
          CreateCard.stubs(:for).returns(false)
        end

        describe '#add' do
          subject { described_class.new(value, id).add }

          context 'when the parent resource exists' do
            context 'and the card was created' do
              before { CreateCard.stubs(:for).returns(true) }

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
            it 'returns a polite message' do
              subject.must_match(/could not/)
            end
          end
        end
      end
    end
  end
end
