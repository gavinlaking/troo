module Troo
  module CLI
    class Default < ThorFixes
      package_name 'default'

      # @param  id [String]
      # @return [String]
      desc 'board <id>',
           'Set the board <id> to default.'
      def board(id)
        say Commands::Default.dispatch(Board, id)
      end

      # @param  id [String]
      # @return [String]
      desc 'card <id>',
           'Set the card <id> to default.'
      def card(id)
        say Commands::Default.dispatch(Card, id)
      end

      # @param  id [String]
      # @return [String]
      desc 'list <id>',
           'Set the list <id> to default.'
      def list(id)
        say Commands::Default.dispatch(List, id)
      end
    end
  end
end
