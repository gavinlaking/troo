module Troo
  module CLI
    class Current < Thor
      desc "board <board_id>", "Set the board <board_id> to current."
      def board(board_id)
        board = SetCurrent.for Troo::BoardRetrieval.retrieve(board_id)
        say "Board '#{board.name}' set to current."
      rescue Trello::Error
        say "Board cannot be found."
      end

      desc "card <card_id>", "Set the card <card_id> to current."
      def card(card_id)
        card = SetCurrent.for Troo::CardRetrieval.retrieve(card_id)
        say "Card '#{card.name}' set to current."
      rescue Trello::Error
        say "Card cannot be found."
      end

      desc "list <list_id>", "Set the list <list_id> to current."
      def list(list_id)
        list = SetCurrent.for Troo::ListRetrieval.retrieve(list_id)
        say "List '#{list.name}' set to current."
      rescue Trello::Error
        say "List cannot be found."
      end
    end
  end
end
