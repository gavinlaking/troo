module Troo
  module Presenters
    class Comment
      include DecoratorHelpers

      class << self
        def show(card, options = {})
          new(card, options).show
        end
      end

      def initialize(card, options = {})
        @card    = card
        @options = options
      end

      def show
        spacing do
          print card.decorator.short

          print_error 'No comments were found.' unless comments.any?

          comments.each do |comment|
            indent { print comment.decorator.as_view }
          end
        end
      end

      private

      attr_reader :card

      def comments
        card.comments
      end
    end
  end
end
