module Troo
  module CLI
    class Refresh < ThorFixes
      package_name 'refresh'

      # @return [String]
      desc 'all',
           'Refresh all the local data.'
      def all
        say Commands::RefreshAll.dispatch
      end

      # @param  [String]
      # @return [String]
      desc 'board (<id>)',
           'Refresh the default board or board with <id>.'
      def board(id = nil)
        say Commands::Refresh.dispatch(Troo::Board, id)
      end

      # @param  [String]
      # @return [String]
      desc 'card (<id>)',
           'Refresh the default card or card with <id>.'
      def card(id = nil)
        say Commands::Refresh.dispatch(Troo::Card, id)
      end

      # @param  [String]
      # @return [String]
      desc 'list (<id>)',
           'Refresh the default list or list with <id>.'
      def list(id = nil)
        say Commands::Refresh.dispatch(Troo::List, id)
      end
    end
  end
end
