module Troo
  module Commands
    module Move
      class Card
        class << self
          def dispatch(card_id, list_id, board_id = nil)
            new(card_id, list_id, board_id).move
          end
        end

        def initialize(card_id, list_id, board_id = nil)
          @card_id, @list_id, @board_id = card_id, list_id, board_id
        end

        def move
          return 'Card cannot be found.'  if card_not_found?
          return 'List cannot be found.'  if list_not_found?
          return 'Board cannot be found.' if board_not_found?
          return success if moved
          error
        end

        private

        attr_reader :card_id, :list_id, :board_id

        def moved
          if board_specified?
            @moved ||= MoveCard.with(external_card_id,
                                     external_list_id,
                                     external_board_id)
          else
            @moved ||= MoveCard.with(external_card_id,
                                     external_list_id)
          end
        end

        def success
          if board_specified?
            "Card '#{card_name}' moved to '#{list_name}' on '#{board_name}'."
          else
            "Card '#{card_name}' moved to '#{list_name}'."
          end
        end

        def error
          'Card could not be moved.'
        end

        def card_name
          card.decorator.name
        end

        def external_card_id
          card.external_card_id
        end

        def card
          @card ||= Troo::Card.retrieve(card_id)
        end

        def card_not_found?
          card.nil?
        end

        def list_name
          list.decorator.name
        end

        def external_list_id
          list.external_list_id
        end

        def list
          @list ||= Troo::List.retrieve(list_id)
        end

        def list_not_found?
          list.nil?
        end

        def board_name
          board.decorator.name
        end

        def external_board_id
          board.external_board_id
        end

        def board
          @board ||= Troo::Board.retrieve(board_id)
        end

        def board_not_found?
          board_specified? && board.nil?
        end

        def board_specified?
          !board_id.nil?
        end
      end
    end
  end
end
