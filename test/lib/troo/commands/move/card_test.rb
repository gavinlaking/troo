require_relative '../../../../test_helper'

module Troo
  module Commands
    module Move
      describe Card do
        let(:described_class) { Card }
        let(:card_id) { '1' }
        let(:list_id) { '2' }
        let(:board_id) {}
        let(:outcome) { false }
        let(:card) { @card }
        let(:list) { @list }
        let(:board) {}

        before do
          @card  = Fabricate.build(:card)
          @list  = Fabricate.build(:list, name: 'Another Test List')
          @board = Fabricate.build(:board)
          Troo::Card.stubs(:retrieve).returns(card)
          Troo::List.stubs(:retrieve).returns(list)
          Troo::Board.stubs(:retrieve).returns(board)
          MoveCard.stubs(:with).returns(outcome)
        end

        describe '#initialize' do
          subject { described_class.new(card_id, list_id, board_id) }

          it 'assigns the card_id to an instance variable' do
            subject.instance_variable_get('@card_id').must_equal(card_id)
          end

          it 'assigns the list_id to an instance variable' do
            subject.instance_variable_get('@list_id').must_equal(list_id)
          end

          it 'assigns the board_id to an instance variable' do
            subject.instance_variable_get('@board_id').must_equal(board_id)
          end
        end

        describe '#move' do
          subject { described_class.dispatch(card_id, list_id, board_id) }

          context 'when the card can be moved' do
            let(:outcome) { true }

            it 'returns a polite message' do
              subject.must_match(/moved to/)
            end

            context 'when the optional board is provided' do
              let(:board_id) { '2' }
              let(:board) { @board }

              it 'returns a polite message' do
                subject.must_match(/Test List\' on \'My/)
              end
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

            context 'when the board does not exist' do
              let(:board_id) { '2' }
              let(:board) {}

              it 'returns a polite message' do
                subject.must_match(/Board cannot be found/)
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
