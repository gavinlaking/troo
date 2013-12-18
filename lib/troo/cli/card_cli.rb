module Troo
  module CLI
    class Card < Thor
      desc "all <board_id>", "Show all the cards for board <board_id>"
      def all(board_id)
        # Troo::CLI::Board.new.cards(board_id)
        say "Not implemented yet."
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        # Troo::Screen.render(Troo::CardDecorator.new(Troo::CardRetrieval.retrieve(card_id)).as_view)
        say "Not implemented yet."
      end
    end
  end
end

