module Troo
  module Presenters
    class Board
      include DecoratorHelpers

      class << self
        def all(boards, options = {})
          boards.map { |board| new(board.decorator, options).show }
          nil
        end
      end

      def initialize(board, options = {})
        @board, @options = board, options
      end

      def show
        output.render board.title

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

      def render_lists
        output.spacer

        board.lists.map do |list|
          Presenters::List.new(list, output: output).render_list
        end

        nil
      end

      private

      attr_reader :board

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
