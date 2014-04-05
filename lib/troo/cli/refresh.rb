module Troo
  module CLI
    class Refresh < ThorFixes
      package_name 'refresh'

      desc 'all',
           'Refresh all the local data.'
      def all
        say Commands::RefreshAll.dispatch
      end

      desc 'board (<id>)',
           'Refresh the default board or board with <id>.'
      # @param  [String]
      # @return [String]
      def board(id = nil)
        say Commands::Refresh.dispatch(Troo::Board, id)
      end

      desc 'card (<id>)',
           'Refresh the default card or card with <id>.'
      # @param  [String]
      # @return [String]
      def card(id = nil)
        say Commands::Refresh.dispatch(Troo::Card, id)
      end

      desc 'list (<id>)',
           'Refresh the default list or list with <id>.'
      # @param  [String]
      # @return [String]
      def list(id = nil)
        say Commands::Refresh.dispatch(Troo::List, id)
      end
    end
  end
end
