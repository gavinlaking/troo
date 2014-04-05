module Troo
  module CLI
    class Show < ThorFixes
      package_name 'show'

      desc 'boards',
           'Show all the boards with lists.'
      def boards
        say Troo::Commands::ShowBoards.dispatch
      end

      desc 'board (<id>)',
           'Show lists and cards for board <id>' \
           ' (uses default board if <id> not provided).'
      # @param  [String]
      # @return [String]
      def board(id = nil)
        say Troo::Commands::Show.dispatch(Troo::Board, id)
      end

      desc 'list (<id>)',
           'Show all cards for list <id>' \
           ' (uses default list if <id> not provided).'
      # @param  [String]
      # @return [String]
      def list(id = nil)
        say Troo::Commands::Show.dispatch(Troo::List, id)
      end

      desc 'card (<id>)',
           'Show a card <id> including last 3 comments' \
           ' (uses default card if <id> not provided).'
      # @param  [String]
      # @return [String]
      def card(id = nil)
        say Troo::Commands::Show.dispatch(Troo::Card, id)
      end

      desc 'comments (<id>)',
           'Show all comments for card <id>' \
           ' (uses default card if <id> not provided).'
      # @param  [String]
      # @return [String]
      def comments(id = nil)
        say Troo::Commands::ShowComments.dispatch(id)
      end
    end
  end
end
