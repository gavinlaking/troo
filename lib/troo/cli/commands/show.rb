module Troo
  module Commands
    class Show
      attr_reader :id, :type

      class << self
        # @param  []
        # @param  []
        # @return [String]
        def dispatch(klass, id = nil)
          new(klass, id).render
        end
      end

      # @param  []
      # @param  []
      # @return [Troo::Commands::Show]
      def initialize(klass, id = nil)
        @klass, @id = klass, id
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
        resource.presenter.show
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
    end
  end
end
