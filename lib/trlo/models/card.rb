module Trlo
  class Card
    def initialize(card, comments = [])
      @card = card
      @comments = comments
    end

    def self.decorate(card, comments = [])
      new(card, comments).decorate
    end

    def decorate
      {
        id: id,
        short_id: short_id,
        name: name,
        header: header,
        comments: comments
      }
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
    attr_reader :card, :comments

    def header
      { short_id: "ID", name: "Name" }
    end
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

