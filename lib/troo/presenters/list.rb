module Troo
  module Presenters
    class List
      include DecoratorHelpers

      # @param  [Troo::List]
      # @return [Troo::Presenters::List]
      def initialize(list, options = {})
        @list, @options = list, options
      end

      # @return [String]
      def show
        output.render Presenters::Resource.list_view(list.board)

        output.spacer

        output.indent do
          render_list
        end
      end

      # @return [String]
      def render_list
        output.render Presenters::Resource.list_view(list)

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

      # @return [String]
      def render_cards
        output.spacer do
          list.cards.map do |card|
            output.render Presenters::Resource.list_view(card)
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
          output: Troo::Compositor.new
        }
      end
    end
  end
end
