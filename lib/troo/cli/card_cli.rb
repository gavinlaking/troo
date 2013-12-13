module Troo
  module CLI
    class Card < Thor
      include Troo::Helpers

      desc "all <board_id>", "Show all the cards for board <board_id>"
      def all(board_id)
        Troo::CLI::Board.new.cards(board_id)
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        Troo::Screen.render(Troo::CardDecorator.new(Troo::CardRetrieval.retrieve(card_id)).as_view)
      end
    end
  end
end

