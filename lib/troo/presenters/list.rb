module Troo
  module Presenters
    class List
      include DecoratorHelpers

      def initialize(list, options = {})
        @list, @options = list, options
      end

      def show
        board

        output.indent do
          render_list
        end
      end

      def board
        output.render list.board.title + "\n"
      end

      def render_list
        output.render list.title

        output.indent do
          if list.cards.empty?
            output.spacer do
              output.render error('No cards were found.')
            end
          else
            render_cards
          end
        end
      end

      def render_cards
        output.spacer do
          list.cards.map do |card|
            output.render card.title
          end
        end
      end

      private

      attr_reader :list

      def output
        @output ||= options.fetch(:output)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {
          output: Troo::Output.new
        }
      end
    end
  end
end
