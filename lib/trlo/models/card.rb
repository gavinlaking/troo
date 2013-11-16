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
end

