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
        output.build(Presenters::Resource.list_view(list.board, options))

        output.spacer

        output.indent do
          render_list
        end

        output.render
      end

      # @return [String]
      def render_list
        output.build(Presenters::Resource.list_view(list, options))

        output.indent do
          if list.cards.empty?
            output.spacer do
              output.build(error("No cards were found."))
            end
          else
            render_cards
          end
        end
      end

      private

      attr_reader :list

      def render_cards
        output.build("\n")
        list.cards.map do |card|
          output.build(Presenters::Resource.list_view(card, options))
        end
        output.build("\n")
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
