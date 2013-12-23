module Troo
  class CardDecorator
    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def short
      [current_str, id_str, name_str].join + "\n"
    end

    def name_str
      highlight(name, options)
    end

    def current_str
      current.center(3)
    end

    def id_str
      highlight(brackets(id) + " ", options).rjust(6)
    end

    def name
      (card.name && card.name.chomp) || "N/A"
    end

    def current
      card.current? ? "*" : ""
    end

    def id
      card.short_id
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
      Time.parse(card.last_activity_date).strftime("%a, %b %d at %H:%M")
    end

    def board
      BoardDecorator.new(card.board, options).short
    end

    def list
      ListDecorator.new(card.list, options).short
    end

    private
    attr_reader :card

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        ansicolor: false,
        colour:    nil,
        underline: nil
      }
    end
  end
end
