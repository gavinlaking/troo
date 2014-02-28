module Troo
  module Commands
    class ShowBoards
      class << self
        def dispatch
          new.render
        end
      end

      def initialize; end

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
        @resources ||= Retrieval::Board.all
      end
    end
  end
end
