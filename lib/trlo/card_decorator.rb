module Trlo
  class CardDecorator
    def initialize(card)
      @card = card
    end

    def short_id
      card.short_id
    end

    def id
      card.id
    end

    def name
      card.name
    end

    def to_hash
      { id: id, short_id: short_id, name: name }
    end

    private
    attr_reader :card
  end
end
