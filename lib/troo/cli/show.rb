module Troo
  module CLI
    class Show < ThorFixes
      package_name 'show'

      # @return [String]
      desc 'boards',
           'Show all the boards with lists.'
      def boards
        say Troo::Commands::ShowBoards.dispatch
      end

      # @param  [String]
      # @return [String]
      desc 'board (<id>)',
           'Show lists and cards for board <id>' \
           ' (uses default board if <id> not provided).'
      def board(id = nil)
        say Troo::Commands::Show.dispatch(Troo::Board, id)
      end

      # @param  [String]
      # @return [String]
      desc 'list (<id>)',
           'Show all cards for list <id>' \
           ' (uses default list if <id> not provided).'
      def list(id = nil)
        say Troo::Commands::Show.dispatch(Troo::List, id)
      end

      # @param  [String]
      # @return [String]
      desc 'card (<id>)',
           'Show a card <id> including last 3 comments' \
           ' (uses default card if <id> not provided).'
      def card(id = nil)
        say Troo::Commands::Show.dispatch(Troo::Card, id)
      end

      # @param  [String]
      # @return [String]
      desc 'comments (<id>)',
           'Show all comments for card <id>' \
           ' (uses default card if <id> not provided).'
      def comments(id = nil)
        say Troo::Commands::ShowComments.dispatch(id)
      end
    end
  end
end
