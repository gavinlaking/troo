module Trlo
  class Card
    def initialize(card)
      @card = card
    end

    def self.decorate(card)
      new(card).decorate
    end

    def decorate
      { id: id, short_id: short_id, name: name, header: header }
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

    private
    attr_reader :card

    def header
      { short_id: "ID", name: "Name" }
    end
  end

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

  class MoveCard
    def initialize(card_id, list_id = nil)
      @card_id = card_id
      @list_id = list_id
    end

    def self.with(card_id, list_id = nil)
      new(card_id, list_id).move
    end

    def move
      if list_id.nil?
        FindLists.for(card.board_id)
        @list_id = ask("Destination list?: ") # mutable
        # MoveCard.with(card_id, list_id)     # immutable
      end
      card.move_to_list(FindList.with(list_id))
    end

    private
    attr_reader   :card_id
    attr_accessor :list_id

    def card
      @card ||= FindCard.with(card_id)
    end
  end
end
