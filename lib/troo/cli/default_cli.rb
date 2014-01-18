module Troo
  module CLI
    class Default < ThorFixes
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

      def set_default(id, type)
        @id, @type = id, type
        return success(resource.name) if SetDefault.for(resource)
        not_found
      end

      def resource
        @resource ||= case @type
        when :board then Troo::BoardRetrieval.retrieve(@id)
        when :list  then Troo::ListRetrieval.retrieve(@id)
        when :card  then Troo::CardRetrieval.retrieve(@id)
        end
      end

      def success(resource_name = "")
        say "'#{resource_name}' set as default #{@type.to_s.downcase}."
      end

      def not_found
        say "#{@type.to_s.capitalize} cannot be found."
      end
    end
  end
end
