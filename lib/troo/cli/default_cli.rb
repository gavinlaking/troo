module Troo
  module CLI
    class Default < ThorFixes
      package_name "default"

      desc "board <board_id>", "Set the board <board_id> to default."
      def board(board_id)
        if board = Troo::BoardRetrieval.retrieve(board_id)
          SetDefault.for(board)
          say "Board '#{board.name}' set to default."
        else
          say "Board cannot be found."
        end
      end

      desc "card <card_id>", "Set the card <card_id> to default."
      def card(card_id)
        if card = Troo::CardRetrieval.retrieve(card_id)
          SetDefault.for(card)
          say "Card '#{card.name}' set to default."
        else
          say "Card cannot be found."
        end
      end

      desc "list <list_id>", "Set the list <list_id> to default."
      def list(list_id)
        if list = Troo::ListRetrieval.retrieve(list_id)
          SetDefault.for(list)
          say "List '#{list.name}' set to default."
        else
          say "List cannot be found."
        end
      end
    end
  end
end
