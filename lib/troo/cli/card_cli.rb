module Troo
  module CLI
    class Card < Thor
      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        @card_id = card_id
        if card
          CardPresenter.render_show(card)
        else
          say "Card not found."
        end
      end

      private
      attr_reader :card_id

      def card
        @card ||= Troo::CardRetrieval.retrieve(card_id)
      end
    end
  end
end

