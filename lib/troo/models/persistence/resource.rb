module Troo
  module Persistence
    class Resource
      attr_reader :resource, :options

      class << self
        def with_collection(resources = [], options = {})
          resources.map do |resource|
            new(resource, options).persist
          end
        end
      end

      def initialize(resource, options = {})
        @resource = resource
        @options  = options
      end

      def persist
        set_default
        delete
        create
      end

      private

      def set_default
        remote_data.merge!(default: true) if default?
      end

      def delete
        local.delete if local_exists?
      end

      def default?
        local_exists? && local.default?
      end

      def local_exists?
        !!local
      end
    end
  end
end
