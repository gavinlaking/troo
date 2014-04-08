module Troo
  module Presenters
    class Board
      include DecoratorHelpers

      class << self
        # @param  [Array]
        # @param  [Hash]
        # @return [NilClass]
        def all(boards, options = {})
          boards.map { |board| new(board, options).show }
          nil
        end
      end

      # @param  [Troo::Board]
      # @param  [Hash]
      # @return [Troo::Presenters::Board]
      def initialize(board, options = {})
        @board, @options = board, options
      end

      # @return []
      def show
        output.render Presenters::Resource.list_view(board)

        output.indent do
          if board.lists.empty?
            output.spacer do
              output.render error('No lists were found.')
            end
          else
            render_lists
          end
        end
      end

      private

      attr_reader :board

      def render_lists
        output.spacer

        board.lists.map do |list|
          Presenters::List.new(list, output: output).render_list
        end

        nil
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
