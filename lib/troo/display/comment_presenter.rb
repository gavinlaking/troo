module Troo
  class CommentPresenter
    class << self
      def show(card, options = {})
        new(card, options).show
      end
    end

    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def show
      spacing do
        print card.decorator.short

        if card.comments.any?
          card.comments.each do |comment|
            indent do
              print comment.decorator.as_view
            end
          end
        else
          print_error "No comments were found."
        end
      end
    end

    private
    attr_reader :card
  end
end
