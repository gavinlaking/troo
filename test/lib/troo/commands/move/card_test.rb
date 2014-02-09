require_relative '../../../../test_helper'

module Troo
  module Commands
    module Move
      describe Card do
        let(:described_class) { Card }
        let(:card_id) { '1' }
        let(:list_id) { '2' }
        let(:outcome) { false }
        let(:card) { @card }
        let(:list) { @list }

        before do
          @card = Fabricate.build(:card)
          @list = Fabricate.build(:list, name: 'Another Test List')
          Retrieval::Card.stubs(:retrieve).returns(card)
          Retrieval::List.stubs(:retrieve).returns(list)
          MoveCard.stubs(:with).returns(outcome)
        end

        describe '#initialize' do
          subject { described_class.new(card_id, list_id) }
        end

        describe '#move' do
          subject { described_class.dispatch(card_id, list_id) }

          context 'when the card can be moved' do
            let(:outcome) { true }

            it 'returns a polite message' do
              subject.must_match(/moved to/)
            end
          end

          context 'when the card cannot be moved' do
            context 'when the card does not exist' do
              let(:card) {}

              it 'returns a polite message' do
                subject.must_match(/Card cannot be found/)
              end
            end

            context 'when the list does not exist' do
              let(:list) {}

              it 'returns a polite message' do
                subject.must_match(/List cannot be found/)
              end
            end

            context 'when the move fails for another reason' do
              let(:outcome) { false }

              it 'returns a polite message' do
                subject.must_match(/could not be moved/)
              end
            end
          end
        end
      end
    end
  end
end
