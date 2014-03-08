module Troo
  module Presenters
    class Card
      include DecoratorHelpers

      def initialize(card, options = {})
        @card    = card
        @options = options
      end

      def show
        print Template.parse(card, '/../views/card.erb')
      end

      private

      attr_reader :card
    end
  end
end
