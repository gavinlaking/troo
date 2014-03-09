module Troo
  module Presenters
    class Card
      include DecoratorHelpers

      def initialize(card, options = {})
        @card, @options = card, options
      end

      def show
        output.render Template.parse(card, '/../views/card.erb')
      end

      private

      attr_reader :card

      def output
        @output ||= Troo::Output.new
      end
    end
  end
end
