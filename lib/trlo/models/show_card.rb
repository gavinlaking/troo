module Trlo
  class ShowCard
    def initialize(card_id)
      @card_id = card_id
    end

    def self.with(card_id)
      new(card_id).show
    end

    def show
      Card.decorate(card, comments)
    end

    private
    attr_reader :card_id

    def card
      @card ||= FindCard.with(card_id)
    end

    def comments
      @comments ||= FindComments.for(card_id)
    end
  end
end
