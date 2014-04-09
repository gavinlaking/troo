module Troo
  module Presenters
    class List
      include DecoratorHelpers

      # @param  [Troo::List]
      # @param  [Hash]
      # @return [Troo::Presenters::List]
      def initialize(list, options = {})
        @list, @options = list, options
      end

      # @return [String]
      def show
        output.build(list_view(list.board))

        output.spacer

        output.indent { render_list }

        output.render
      end

      # @return [String]
      def render_list
        output.build(list_view(list))

        output.indent do
          if list.cards.empty?
            output.spacer do
              output.build(error('No cards were found.', options))
            end
          else
            render_cards
          end
        end
      end

      private

      attr_reader :list

      def render_cards
        output.spacer do
          list.cards.map { |card| output.build(list_view(card)) }
        end
      end

      def output
        @output ||= options.fetch(:output)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {
          output: Troo::Compositor.new
        }
      end
    end
  end
end
