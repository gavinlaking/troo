module Troo
  module CLI
    class Board < Thor

      desc "all", "Show all the boards with lists"
      def all
        if boards.any?
          boards.map do |board|
            BoardPresenter.render_all(board)
          end
        else
          say "Boards not found."
        end
      end

      desc "show <board_id>", "Show all the lists and cards for board <board_id>"
      def show(board_id)
        @board_id = board_id
        if board
          BoardPresenter.render_show(board)
        else
          say "Board not found."
        end
      end

      private
      attr_reader :board_id

      def board
        @board ||= Troo::BoardRetrieval.retrieve(board_id)
      end

      def boards
        @boards ||= Troo::BoardRetrieval.retrieve
      end
    end
  end
end
