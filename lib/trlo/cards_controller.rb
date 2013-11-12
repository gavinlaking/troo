module Trlo
  class CardsController
    def initialize(options, arguments)
      @options   = options
      @arguments = arguments
    end

    def self.dispatch!(options, arguments)
      new(options, arguments).dispatch
    end

    def dispatch
      options.each do |option|
        case option
        when :all
          list_id = arguments[0]
          Output.new(FindCards.for(list_id)).render
        when :comment
          list_id = arguments[0]
          CreateComment.for(list_id)
        when :move
          card_id = arguments[0]
          list_id = arguments[1]
          MoveCard.with(card_id, list_id)
        when :show
          card_id = arguments[0]
          ShowCard.with(card_id)
        end
      end
    end

    private
    attr_reader :arguments

    def options
      @options.delete_if { |_, v| v.nil? }.keys
    end
  end
end

