module Troo
  class CardDecorator
    def initialize(card)
      @card = card
    end

    def name
      card.name
    end

    def description
      if card.desc.nil? || card.desc.empty?
        "There are no further details at this time."
      else
        card.desc
      end
    end

    def comments
      if card.comments.any?
        #card.comments.map { |comment| CommentDecorator.new(comment).as_view }.join
        "There are some comments."
      else
        "No comments have been left."
      end
    end

    def members
      if card.members.any?
        "There are some members."
      else
        "No members have been assigned."
      end
    end

    def last_activity_date
      card.last_activity_date.strftime("%a, %b %d at %H:%M")
    end

    def current
      card.current? ? "*" : ""
    end

    def id
      brackets(card.short_id)
    end

    private
    attr_reader :card

    def brackets(value)
      "(#{value})"
    end
  end
end
