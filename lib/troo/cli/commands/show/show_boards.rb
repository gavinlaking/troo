module Troo
  module Commands
    class ShowBoards
      class << self
        # @param  [Hash]
        # @return [String]
        def dispatch(options = {})
          new(options).render
        end
      end

      # @param  options [Hash]
      # @return [Troo::Commands::ShowBoards]
      def initialize(options = {})
        @options = options
      end

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
