module Troo
  class ListPresenter
    class << self
      def show(list, options = {})
        new(list, options).show
      end
    end

    include DecoratorHelpers

    def initialize(list, options = {})
      @list   = list
      @options = options
    end

    def show
      spacing do
        print board.decorator.short

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
    end

    private
    attr_reader :list

    def board
      list.board
    end
  end
end
