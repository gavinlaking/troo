module Troo
  module Commands
    class Show
      attr_reader :id, :type

      class << self
        # @param  klass   []
        # @param  id      [, NilClass]
        # @param  options [Hash]
        # @return [String]
        def dispatch(klass, id, options = {})
          new(klass, id, options).render
        end
      end

      # @param  klass   []
      # @param  id      [, NilClass]
      # @param  options [Hash]
      # @return [Troo::Commands::Show]
      def initialize(klass, id, options = {})
        @klass, @id, @options = klass, id, options
      end

      # @return [String]
      def render
        if resource
          presenter
        elsif no_default?
          [error, no_default].join(' ')
        else
          error
        end
      end

      private

      attr_reader :klass

      def presenter
        resource.presenter(options).show
      end

      def error
        "#{type.capitalize} cannot be found."
      end

      def no_default?
        id.nil? && resource.nil?
      end

      def no_default
        "Specify an <id> or use 'troo default #{type} <id>' " \
        "to set a default #{type} first."
      end

      def type
        klass.type.to_s
      end

      def resource
        @resource ||= klass.retrieve(id)
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
