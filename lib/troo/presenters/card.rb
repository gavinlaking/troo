module Troo
  module Presenters
    class Card
      include DecoratorHelpers

      # @param  [Troo::Card]
      # @param  [Hash]
      # @return [Troo::Presenter::Card]
      def initialize(card, options = {})
        @card, @options = card, options
      end

      # @return [String]
      def show
        output.build(Template.parse(card, '/../views/card.erb'))
        output.render
      end

      private

      attr_reader :options

      def card
        Troo::Decorators::Resource.new(@card, options)
      end

      def output
        @output ||= Troo::Compositor.new
      end
    end
  end
end
