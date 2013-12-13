module Troo
  class ProxyCard
    def initialize(card)
      @card = card
    end

    def self.for(card)
      new(card).duck
    end

    def duck
      Trello::Card.new.update_fields({'id' => card.external_card_id})
    end

    private
    attr_reader :card
  end
end
