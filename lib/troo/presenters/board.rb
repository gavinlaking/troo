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
          if lists.empty?
            output.render error('No lists were found.') + "\n"
          else
            print_lists_with_cards
          end
        end
      end

      private

      attr_reader :board

      def output
        @output ||= Troo::Output.new
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end

      def print_lists_with_cards
        output.render "\n"
        lists.each do |list|
          output.render list.title

          output.indent do
            if list.cards.empty?
              output.render error('No cards were found.') + "\n"
            else
              output.render "\n"
              list.cards.each do |card|
                output.render card.title
              end
              output.render "\n"
            end
          end
        end
        nil
      end

      def lists
        board.lists
      end
    end
  end
end
