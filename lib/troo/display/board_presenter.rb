module Troo
  class BoardPresenter
    class << self
      def render_all(board, options = {})
        new(board, options).render_all
      end

      def show(board, options = {})
        new(board, options).show
      end
    end

    include DecoratorHelpers

    def initialize(board, options = {})
      @board   = board
      @options = options
    end

    def render_all
      puts board.decorator.title

      print_error "No lists were found." if lists.empty?

      print_lists
    end

    def show
      puts board.decorator.title

      print_error "No lists were found." if lists.empty?

      print_lists_with_cards
    end

    private
    attr_reader :board

    def print_lists_with_cards
      lists.each do |list|
        title_for(list)

        print_error "No cards were found." if list.cards.empty?

        list.cards(unformatted).each do |card|
          title_for(card)
        end
      end
      puts
    end

    def print_lists
      lists.each do |list|
        title_for(list)
      end
      puts
    end

    def lists
      board.decorator.lists
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
