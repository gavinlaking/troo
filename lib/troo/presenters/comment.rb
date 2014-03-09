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

      def output
        @output ||= Troo::Output.new
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end

      def all_comments
        comments.map do |comment|
          output.render comment.decorator.as_view
        end
        nil
      end

      def no_comments
        output.render error('No comments were found.')
      end

      def comments?
        comments.any?
      end

      def comments
        @comments ||= card.comments
      end

      def title
        output.render card.decorator.title + "\n"
      end
    end
  end
end
