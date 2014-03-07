module Troo
  module Presenters
    class Board
      include DecoratorHelpers

      class << self
        def all(boards, options = {})
          boards.map { |board| new(board.decorator, options).show }
        end
      end

      def initialize(board, options = {})
        @board, @options = board, options
      end

      def show
        print board.title + "\n"

        print error('No lists were found.') if lists.empty?

        print_lists_with_cards

        puts
      end

      private

      attr_reader :board

      def print_lists_with_cards
        lists.each do |list|
          print list.title

          print error('No cards were found.') if list.cards.empty?

          list.cards.each do |card|
            print card.title
          end
        end
        puts
      end

      def lists
        board.lists
      end
    end
  end
end
