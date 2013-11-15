module Trlo
  class FindCards
    def initialize(list_id)
      @list_id = list_id
    end

    def self.for(list_id)
      new(list_id).all_cards
    end

    def all_cards
      FindList.with(list_id).cards.map do |card|
        Card.decorate(card)
      end
    end

    private
    attr_reader :list_id
  end
end
