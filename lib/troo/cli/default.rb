module Troo
  module CLI
    class Default < ThorFixes
      package_name 'default'

      desc 'board <id>',
           'Set the board <id> to default.'
      # @param  [String]
      # @return [String]
      def board(id)
        say Commands::Default.dispatch(Board, id)
      end

      desc 'card <id>',
           'Set the card <id> to default.'
      # @param  [String]
      # @return [String]
      def card(id)
        say Commands::Default.dispatch(Card, id)
      end

      desc 'list <id>',
           'Set the list <id> to default.'
      # @param  [String]
      # @return [String]
      def list(id)
        say Commands::Default.dispatch(List, id)
      end
    end
  end
end
