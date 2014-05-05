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

        output.render
      end

      private

      attr_reader :card

      def output
        @output ||= Troo::Compositor.new
      end

      def all_comments
        comments.map do |comment|
          output.build(comment.decorator.as_view)
        end
      end

      def no_comments
        output.build(error('No comments were found.', options))
      end

      def comments?
        comments.any?
      end

      def comments
        @comments ||= card.comments
      end

      def title
        output.build(card.decorator.title + "\n")
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end
    end
  end
end
