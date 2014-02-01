module Troo
  module CLI
    class Refresh < ThorFixes
      package_name "refresh"

      desc "all",
           "Refresh all the local data."
      def all
        say Commands::RefreshAll.dispatch
      end

      desc "board (<id>)",
           "Refresh the default board or board with <id>."
      def board(id = nil)
        say Commands::Refresh::Board.dispatch(id)
      end

      desc "card (<id>)",
           "Refresh the default card or card with <id>."
      def card(id = nil)
        say Commands::Refresh::Card.dispatch(id)
      end

      desc "list (<id>)",
           "Refresh the default list or list with <id>."
      def list(id = nil)
        say Commands::Refresh::List.dispatch(id)
      end
    end
  end
end
