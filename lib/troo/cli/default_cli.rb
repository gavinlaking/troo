module Troo
  module CLI
    class Default < ThorFixes
      package_name "default"

      desc "board <id>", "Set the board <id> to default."
      def board(id)
        say Commands::Default.dispatch(:board, id)
      end

      desc "card <id>", "Set the card <id> to default."
      def card(id)
        say Commands::Default.dispatch(:card, id)
      end

      desc "list <id>", "Set the list <id> to default."
      def list(id)
        say Commands::Default.dispatch(:list, id)
      end
    end
  end
end
