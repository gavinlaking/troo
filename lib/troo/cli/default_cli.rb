module Troo
  module CLI
    class Default < ThorFixes
      include Helpers

      package_name "default"

      desc "board <id>", "Set the board <id> to default."
      def board(id)
        set_default(id, :board)
      end

      desc "card <id>", "Set the card <id> to default."
      def card(id)
        set_default(id, :card)
      end

      desc "list <id>", "Set the list <id> to default."
      def list(id)
        set_default(id, :list)
      end

      private
      attr_reader :id, :type

      def set_default(id, type)
        @id, @type = id, type
        return success(resource.name) if SetDefault.for(resource)
        not_found
      end

      def success(resource_name = "")
        say "'#{resource_name}' set as default #{type.to_s.downcase}."
      end
    end
  end
end
