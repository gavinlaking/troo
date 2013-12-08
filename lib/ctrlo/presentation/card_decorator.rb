module Ctrlo
  class CardDecorator
    def initialize(card)
      @card = card
    end

    def as_view
      Template.parse(self, "/../views/card.erb")
    end

    def title
      [ card_id, card_name ].join(" ")
    end

    def description
      card_description
    end

    def comments
      card_comments
    end

    def members
      card_members
    end

    def board
      [ board_name, board_id ].join(" ")
    end

    def list
      [ list_name, list_id ].join(" ")
    end

    def last_updated
      card.last_activity_date.strftime("%a, %b %d at %H:%M")
    end

    private
    attr_reader :card

    def card_members
      if card.members.any?
        "There are some members."
      else
        "There are no members assigned to this card."
      end
    end

    def card_comments
      if card.comments.any?
        card.comments.map { |comment| CommentDecorator.new(comment).as_view }.join
      else
        "There are no comments at this time."
      end
    end

    def card_description
      if card.desc.empty?
        "There are no further details at this time."
      else
        card.desc
      end
    end

    def card_name
      [ Esc.yellow, card.name, Esc.reset ].join
    end

    def card_id
      [ Esc.green, card_idstr, Esc.reset ].join
    end

    def card_idstr
      brackets(card.id.to_s).ljust(6)
    end

    def board_name
      card.board.name
    end

    def board_id
      brackets(card.board.id.to_s)
    end

    def list_name
      card.list.name
    end

    def list_id
      brackets(card.list.id.to_s)
    end

    def brackets(string = nil)
      "(" + string + ")"
    end
  end
end
