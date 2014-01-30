module Troo
  module CLI
    class Show < ThorFixes
      package_name "show"

      desc "boards", "Show all the boards with lists."
      def boards
        say Troo::Commands::Show::Boards.dispatch
      end

      desc "board (<id>)", "Show lists and cards for board <id> (uses default board if <id> not provided)."
      def board(id = nil)
        say Troo::Commands::Show::Board.dispatch(:board, id)
      end

      desc "list (<id>)", "Show all cards for list <id> (uses default list if <id> not provided)."
      def list(id = nil)
        say Troo::Commands::Show::List.dispatch(:list, id)
      end

      desc "card (<id>)", "Show a card including latest 3 comments for card <id> (uses default card if <id> not provided)."
      def card(id = nil)
        say Troo::Commands::Show::Card.dispatch(:card, id)
      end

      desc "comments (<id>)", "Show all comments for card <id> (uses default card if <id> not provided)."
      def comments(id = nil)
        say Troo::Commands::Show::Comments.dispatch(:comments, id)
      end
    end
  end
end
