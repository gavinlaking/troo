module Troo
  module CLI
    class Refresh < ThorFixes
      package_name "refresh"

      desc "all", "Refresh all the local data."
      def all
        say Commands::RefreshAll.dispatch
      end

      desc "board", "Refresh the board with <id>."
      def board(id)
        say Commands::Refresh.dispatch(:board, id)
      end

      desc "card <id>", "Refresh the card with <id>."
      def card(id)
        say Commands::Refresh.dispatch(:card, id)
      end

      desc "list <id>", "Refresh the list with <id>."
      def list(id)
        say Commands::Refresh.dispatch(:list, id)
      end
    end
  end
end
