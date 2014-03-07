module Troo
  module Presenters
    class List
      include DecoratorHelpers

      def initialize(list, options = {})
        @list    = list
        @options = options
      end

      def show
        print list.board.title + "\n"

        print list.title

        print error('No cards were found.') if list.cards.empty?

        list.cards.each do |card|
          print card.title
        end

        puts
      end

      private

      attr_reader :list
    end
  end
end
