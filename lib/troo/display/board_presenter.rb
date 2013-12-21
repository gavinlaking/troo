module Troo
  class BoardPresenter
    include DecoratorHelpers

    def initialize(board, options = {})
      @board   = board
      @options = options
    end

    def self.render_all(board, options = {})
      new(board, options).render_all
    end

    def render_all
      spacing({foot: false}) do
        print BoardDecorator.new(board).short

        if board.lists.any?
          board.lists.each do |list|
            indent do
              print ListDecorator.new(list).short
            end
          end
        else
          print_error "No lists were found.\n"
        end
      end
    end

    def self.render_show(board, options = {})
      new(board, options).render_show
    end

    def render_show
      spacing do
        print BoardDecorator.new(board).short

        if board.lists.any?
          board.lists.each do |list|
            indent do
              print ListDecorator.new(list).short

              if list.cards.any?
                list.cards.each do |card|
                  indent do
                    print CardDecorator.new(card).short
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
