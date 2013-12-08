module Ctrlo
  module CLI
    class Card < Thor
      include Ctrlo::Helpers

      desc "all", "Show all the cards for the current list or for <list_id>"
      def all(list_id = nil)
        if list_id
          #Output.render(Ctrlo::ListRetrieval.retrieve(list_id).cards)
        else
          #Output.render(Ctrlo::List.current.cards)
        end
      rescue => e
        error(e.message)
      end

      desc "current <card_id>", "Set the current card to <card_id>"
      def current(card_id)
        card = SetCurrent.for Ctrlo::CardRetrieval.retrieve(card_id)
      ensure
        notify "'#{card.name}' set to current card."
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        Ctrlo::Screen.render(Ctrlo::CardDecorator.decorate(Ctrlo::CardRetrieval.retrieve(card_id)))
      end

      desc "comment", "Comment on a card with <card_id> <comment>"
      def comment(card_id, comment = nil)
        Ctrlo::CreateComment.for(card_id, comment)

        Ctrlo::ExternalCard.fetch(card_id, { mode: :card })
        Ctrlo::ExternalComments.fetch(card_id, { mode: :card })
      end

      desc "move", "Move a card <card_id> to list <list_id>"
      def move(card_id, list_id = nil)
        unless list_id
          #Output.render(Ctrlo::Board.current.lists)
          error("Please choose a destination list. (Move a card <card_id> to list <list_id>)")
          exit 1
        end

        result = MoveCard.with(card_id, list_id)

        Ctrlo::ExternalList.fetch(result.source_list_id, { mode: :list })
        Ctrlo::ExternalList.fetch(result.destination_list_id, { mode: :list })
        Ctrlo::ExternalCard.fetch(card_id, { mode: :card })
      end
    end
  end
end

