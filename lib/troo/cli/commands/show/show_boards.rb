module Troo
  module Commands
    class ShowBoards
      class << self
        # @return [String]
        def dispatch
          new.render
        end
      end

      # @return [Troo::Commands::ShowBoards]
      def initialize; end

      # @return [String]
      def render
        return presenter if resources.any?
        error
      end

      private

      def error
        "#{type.capitalize} cannot be found."
      end

      def type
        'boards'
      end

      def presenter
        Presenters::Board.all(resources)
      end

      def resources
        @resources ||= Troo::Retrieval::Local.all(Troo::Board)
      end
    end
  end
end
