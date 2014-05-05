module Troo
  module Presenters
    class Board
      include DecoratorHelpers

      class << self
        def all(boards, options = {})
          output = Troo::Compositor.new
          output.build(boards.map { |board| new(board, options).show })
          output.render
        end
      end

      def initialize(board, options = {})
        @board, @options = board, options
      end

      def show
        output.build(list_view(board, options))

        output.indent do
          if board.lists.empty?
            output.spacer do
              output.build(error('No lists were found.', options))
            end
          else
            render_lists
          end
        end

        output.render
      end

      private

      attr_reader :board

      def render_lists
        output.spacer

        board.lists.map do |list|
          Presenters::List.new(list, options.merge!(output: output)).render_list
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
