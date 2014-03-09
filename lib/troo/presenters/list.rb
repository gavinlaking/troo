module Troo
  module Presenters
    class List
      include DecoratorHelpers

      def initialize(list, options = {})
        @list, @options = list, options
      end

      def show
        output.render list.board.title
        output.render "\n"

        output.indent do
          output.render list.title

          output.indent do
            if cards.empty?
              output.render error('No cards were found.') + "\n"
            else
              print_list_with_cards
            end
          end
        end
      end

      private

      attr_reader :list

      def output
        @output ||= Troo::Output.new
      end

      def print_list_with_cards
        output.render "\n"
        cards.each do |card|
          output.render card.title
        end
        nil
      end

      def cards
        list.cards
      end
    end
  end
end
