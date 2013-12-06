module Ctrlo
  class MoveCard
    def initialize(card_id, list_id)
      @card_id = card_id
      @list_id = list_id
    end

    def self.with(card_id, list_id)
      new(card_id, list_id).move
    end

    def move
      proxy_card.move_to_list(destination_list_id)
      self
    end

    def source_list_id
      card.external_list_id
    end

    def destination_list_id
      list.external_list_id
    end

    private
    attr_reader :card_id, :list_id

    def proxy_card
      ProxyCard.for card
    end

    def list
      @list ||= Ctrlo::List.retrieve(list_id)
    end

    def card
      @card ||= Ctrlo::Card.retrieve(card_id)
    end
  end
end
