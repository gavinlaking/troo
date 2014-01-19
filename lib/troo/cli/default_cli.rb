module Troo
  module CLI
    class Default < ThorFixes
      include Helpers

      package_name "default"

      desc "board <id>", "Set the board <id> to default."
      def board(id)
        initialize_and_dispatch(id, :board)
      end

      desc "card <id>", "Set the card <id> to default."
      def card(id)
        initialize_and_dispatch(id, :card)
      end

      desc "list <id>", "Set the list <id> to default."
      def list(id)
        initialize_and_dispatch(id, :list)
      end

      private
      attr_reader :id, :type

      def initialize_and_dispatch(id, type)
        @id, @type = id, type
        set_default
      end
    end
  end
end
