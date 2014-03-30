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

      # @return []
      def show
        output.render Template.parse(card, '/../views/card.erb')
      end

      private

      def card
        Troo::Decorators::Resource.new(@card)
      end

      def output
        @output ||= Troo::Compositor.new
      end
    end
  end
end
