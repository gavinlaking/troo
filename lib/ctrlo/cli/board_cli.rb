module Ctrlo
  module CLI
    class Board < Thor
      include Ctrlo::Helpers

      desc "all", "Show all the boards"
      def all
        Ctrlo::Screen.render(Ctrlo::BoardRetrieval.retrieve.map { |board| Ctrlo::BoardDecorator.new(board).as_view }.join)
      end

      desc "current <board_id>", "Set the current board to <board_id>"
      def current(board_id)
        board = SetCurrent.for Ctrlo::BoardRetrieval.retrieve(board_id)
        puts "Board '#{board.name}' set to current."
      rescue Trello::Error
        puts "Board cannot be found."
      end

      desc "show <board_id>", "Show a board <board_id> (includes lists)"
      def show
        puts "Not implemented yet."
      end
    end
  end
end
