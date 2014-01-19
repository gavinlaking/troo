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

        print_error "No comments were found." unless card.comments.any?

        card.comments.each do |comment|
          indent { print comment.decorator.as_view }
        end
      end
    end

    private
    attr_reader :card
  end
end
