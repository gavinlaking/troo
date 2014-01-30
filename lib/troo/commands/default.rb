module Troo
  module Commands
    class Default
      include CommandHelpers

      class << self
        def dispatch(type, id = nil)
          new(type, id).set_default
        end
      end

      def initialize(type, id = nil)
        @type, @id = type, id
      end

      def set_default
        return success if resource && resource.set_default!
        error
      end

      private
      attr_reader :type, :id

      def success
        "'#{resource_name}' set as default #{type_str}."
      end

      def error
        "#{type_capitalize} cannot be found."
      end

      def resource_name
        resource.decorator.name
      end

      def resource
        case type
        when :board then BoardRetrieval.retrieve(id)
        when :list  then ListRetrieval.retrieve(id)
        when :card  then CardRetrieval.retrieve(id)
        end
      end
    end
  end
end
