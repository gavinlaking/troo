module Troo
  module Presenters
    class List
      include DecoratorHelpers

      class << self
        def show(list, options = {})
          new(list, options).show
        end
      end

      def initialize(list, options = {})
        @list    = list
        @options = options
      end

      def show
        puts board.decorator.title

        title_for(list.decorator)

        print_error "No cards were found." if cards.empty?

        cards.each do |card|
          title_for(card)
        end

        puts
      end

      private
      attr_reader :list

      def board
        list.board
      end

      def cards
        list.decorator.cards
      end
    end
  end
end
