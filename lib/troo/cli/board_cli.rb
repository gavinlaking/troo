module Troo
  module CLI
    class Board < ThorFixes
      desc "all", "Show all the boards with lists."
      def all
        if boards.any?
          boards.map do |board|
            BoardPresenter.render_all(board)
          end
        else
          say "Boards not found."
        end
      end

      private

      def boards
        @boards ||= Troo::BoardRetrieval.retrieve
      end
    end
  end
end
