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
        when :add
          puts "Not implemented yet."
        when :delete
          puts "Not implemented yet."
        when :show
          puts "Not implemented yet."
        when :comment
          puts "Not implemented yet."
        when :move
          puts "Not implemented yet."
        end
      end
    end

    private
    attr_reader :arguments

    def options
      @options.delete_if { |_, v| v.nil? }.keys
    end

    # def all(list_id)
    #   render all_cards(list_id)
    # end

    # def show(card_id)
    #   render card(card_id)
    # end

    # def all_cards(list_id)
    #   Trello::List.find(list_id).cards
    # end

    # def card(card_id)
    #   [Trello::Card.find(card_id)]
    # end
  end
end
