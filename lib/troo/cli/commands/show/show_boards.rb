module Troo
  module Commands
    class ShowBoards
      class << self
        def dispatch(options = {})
          new(options).render
        end
      end

      def initialize(options = {})
        @options = options
      end

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
        Presenters::Board.all(resources, options)
      end

      def resources
        @resources ||= Troo::Retrieval::Local.all(Troo::Board)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end
    end
  end
end
