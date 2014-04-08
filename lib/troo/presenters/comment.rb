module Troo
  module Presenters
    class Comment
      include DecoratorHelpers

      # @param  [Troo::Card]
      # @param  [Hash]
      # @return [Troo::Presenters::Comment]
      def initialize(card, options = {})
        @card, @options = card, options
      end

      # @return [String]
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
        output.build(error('No comments were found.'))
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
    end
  end
end
