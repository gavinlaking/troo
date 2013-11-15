module Trlo
  class FindCard
    def initialize(card_id)
      @card_id = card_id
    end

    def self.with(card_id)
      new(card_id).find
    end

    def find
      Trello::Card.find(card_id)
    end

    private
    attr_reader :card_id
  end
end
