module Ctrlo
  module CLI
    class Card < Thor
      include Ctrlo::Helpers

      desc "all <board_id>", "Show all the cards for board <board_id>"
      def all(board_id)
        Ctrlo::CLI::Board.new.cards(board_id)
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        Ctrlo::Screen.render(Ctrlo::CardDecorator.new(Ctrlo::CardRetrieval.retrieve(card_id)).as_view)
      end
    end
  end
end

