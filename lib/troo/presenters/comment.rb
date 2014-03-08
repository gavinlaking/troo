module Troo
  module Presenters
    class Comment
      include DecoratorHelpers

      def initialize(card, options = {})
        @card, @options = card, options
      end

      def show
        title

        if comments?
          all_comments
        else
          no_comments
        end
      end

      private

      attr_reader :card

      def all_comments
        comments.map do |comment|
          print comment.decorator.as_view
        end
        nil
      end

      def no_comments
        print error('No comments were found.')
      end

      def comments?
        comments.any?
      end

      def comments
        @comments ||= card.comments
      end

      def title
        print card.decorator.title + "\n"
      end
    end
  end
end
