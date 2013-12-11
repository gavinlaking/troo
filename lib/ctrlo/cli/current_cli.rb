module Ctrlo
  module CLI
    class Current < Thor
      include Ctrlo::Helpers

      desc "board <board_id>", "Set the board <board_id> to current."
      def board(board_id)
        board = SetCurrent.for Ctrlo::BoardRetrieval.retrieve(board_id)
        puts "Board '#{board.name}' set to current."
      rescue Trello::Error
        puts "Board cannot be found."
      end

      desc "card <card_id>", "Set the card <card_id> to current."
      def card(card_id)
        card = SetCurrent.for Ctrlo::CardRetrieval.retrieve(card_id)
        puts "Card '#{card.name}' set to current."
      rescue Trello::Error
        puts "Card cannot be found."
      end

      desc "list <list_id>", "Set the list <list_id> to current."
      def list(list_id)
        list = SetCurrent.for Ctrlo::ListRetrieval.retrieve(list_id)
        puts "List '#{list.name}' set to current."
      rescue Trello::Error
        puts "List cannot be found."
      end
    end
  end
end
