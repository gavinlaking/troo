module Troo
  module Presenters
    class Board
      include DecoratorHelpers

      class << self
        def all(boards, options = {})
          new(boards, options).all
        end

        def show(board, options = {})
          new(board, options).show
        end
      end

      def initialize(board_or_boards, options = {})
        @board   = board_or_boards
        @options = options
      end

      def all
        boards.map do |board|
          puts board.decorator.title

          print_error 'No lists were found.' if lists(board).empty?

          print_lists(board)
        end
      end

      def show
        puts board.decorator.title

        print_error 'No lists were found.' if lists.empty?

        print_lists_with_cards
      end

      private
      attr_reader  :board
      alias_method :boards, :board

      def print_lists_with_cards
        lists.each do |list|
          title_for(list)

          print_error 'No cards were found.' if list.cards.empty?

          list.cards(unformatted).each do |card|
            title_for(card)
          end
        end
        puts
      end

      def print_lists(optional_board = nil)
        lists(optional_board).each do |list|
          title_for(list)
        end
        puts
      end

      def lists(optional_board = nil)
        if optional_board.nil?
          board.decorator.lists
        else
          optional_board.decorator.lists
        end
      end

      def unformatted
        {
          ansicolor: false,
          colour:    nil,
          underline: nil
        }
      end
    end
  end
end
