module Troo
  module Commands
    class Default
      class << self
        def dispatch(klass, id)
          new(klass, id).set_default
        end
      end

      def initialize(klass, id)
        @klass, @id = klass, id
      end

      def set_default
        return success if resource && resource.set_default!
        error
      end

      private

      attr_reader :id, :klass

      def success
        "'#{name}' set as default #{type.downcase}."
      end

      def error
        "#{type} cannot be found."
      end

      def type
        klass.to_s
      end

      def name
        resource.decorator.name
      end

      def resource
        @resource ||= klass.retrieve(id)
      end
    end
  end
end