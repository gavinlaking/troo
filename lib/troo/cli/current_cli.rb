module Troo
  module CLI
    class Current < ThorFixes
      package_name "current"

      desc "board <board_id>", "Set the board <board_id> to current."
      def board(board_id)
        if board = Troo::BoardRetrieval.retrieve(board_id)
          SetCurrent.for(board)
          say "Board '#{board.name}' set to current."
        else
          say "Board cannot be found."
        end
      end

      desc "card <card_id>", "Set the card <card_id> to current."
      def card(card_id)
        if card = Troo::CardRetrieval.retrieve(card_id)
          SetCurrent.for(card)
          say "Card '#{card.name}' set to current."
        else
          say "Card cannot be found."
        end
      end

      desc "list <list_id>", "Set the list <list_id> to current."
      def list(list_id)
        if list = Troo::ListRetrieval.retrieve(list_id)
          SetCurrent.for(list)
          say "List '#{list.name}' set to current."
        else
          say "List cannot be found."
        end
      end
    end
  end
end
