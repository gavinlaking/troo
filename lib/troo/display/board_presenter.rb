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
      spacing({foot: false}) do
        print board.decorator.short

        if board.lists.any?
          board.lists.each do |list|
            indent do
              print list.decorator.short
            end
          end
        else
          print_error "No lists were found.\n"
        end
      end
    end

    def show
      spacing do
        print board.decorator.short

        if board.lists.any?
          board.lists.each do |list|
            indent do
              print list.decorator.short

              if list.cards.any?
                list.cards.each do |card|
                  indent do
                    print card.decorator.short
                  end
                end
              else
                print_error "No cards were found."
              end
            end
          end
        else
          print_error "No lists were found."
        end
      end
    end

    private
    attr_reader :board
  end
end
