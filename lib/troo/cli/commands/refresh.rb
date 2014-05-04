module Troo
  module Commands
    class Refresh
      attr_reader :id

      class << self
        def dispatch(klass, id = nil)
          new(klass, id).refresh
        end
      end

      def initialize(klass, id = nil)
        @klass, @id = klass, id
      end

      def refresh
        return not_found    if not_found?
        return many_success if multiple_refreshed?

        success
      end

      private

      attr_reader :klass

      def many_success
        "Multiple #{type}s refreshed."
      end

      def multiple_refreshed?
        resource.count > 1
      end

      def success
        "'#{resource_name}' refreshed."
      end

      def not_found
        return [error, no_default].join(' ') unless id

        error
      end

      def not_found?
        resource.nil? || resource.none?
      end

      def error
        "#{type.capitalize} cannot be found."
      end

      def no_default
        "Specify an <id> or use 'troo default #{type} <id>' " \
        "to set a default #{type} first."
      end

      def type
        klass.type.to_s
      end

      def resource_name
        resource.first.decorator.name
      end

      def resource
        return [] unless local

        remote
      end

      def remote
        @remote ||= Retrieval::Remote
          .fetch(klass.remote, local.external_id)
      end

      def local
        @local ||= Retrieval::Local
          .retrieve(klass, id, allow_remote: false)
      end
    end
  end
end
