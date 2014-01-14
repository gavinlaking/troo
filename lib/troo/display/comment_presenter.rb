module Troo
  class CommentPresenter
    class << self
      def render_show(card, options = {})
        new(card, options).render_show
      end
    end

    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def render_show
      spacing do
        print CardDecorator.new(card).short

        if card.comments.any?
          card.comments.each do |comment|
            indent do
              print CommentDecorator.new(comment).as_view
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
