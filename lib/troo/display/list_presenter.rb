module Troo
  class ListPresenter
    class << self
      def render_show(list, options = {})
        new(list, options).render_show
      end
    end

    include DecoratorHelpers

    def initialize(list, options = {})
      @list   = list
      @options = options
    end

    def render_show
      spacing do
        print BoardDecorator.new(board).short

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
    end

    private
    attr_reader :list

    def board
      list.board
    end
  end
end
