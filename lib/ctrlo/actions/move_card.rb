module Ctrlo
  class MoveCard
    def initialize(card_id, list_id)
      @card_id, @list_id = card_id, list_id
    end

    def self.with(card_id, list_id)
      new(card_id, list_id).move
    end

    def move
      proxy_card.move_to_list(external_list_id)
    end

    private
    attr_reader :card_id, :list_id

    def external_list_id
      Ctrlo::List.retrieve(list_id).external_list_id
    end

    def proxy_card
      ProxyCard.for(Ctrlo::Card.retrieve(card_id))
    end
  end
end
