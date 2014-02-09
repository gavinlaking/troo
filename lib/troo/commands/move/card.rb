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
          return 'Card cannot be found.' unless card
          return 'List cannot be found.' unless list
          return success if moved?
          error
        end

        private

        attr_reader :card_id, :list_id, :board_id

        def moved?
          @moved ||= MoveCard.with(card, list)
        end

        def success
          "Card '#{card.decorator.name}' moved to " \
          "'#{list.decorator.name}'."
        end

        def error
          'Card could not be moved.'
        end

        def card
          @card ||= Retrieval::Card.retrieve(card_id)
        end

        def list
          @list ||= Retrieval::List.retrieve(list_id)
        end
      end
    end
  end
end
