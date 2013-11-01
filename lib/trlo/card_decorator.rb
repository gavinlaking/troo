module Trlo
  class CardDecorator
    def initialize(card)
      @card = card
    end

    def id
      card.id
    end

    def name
      card.name
    end

    def to_hash
      { id: id, name: name }
    end

    private
    attr_reader :card
  end
end