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
        preprocess
        set_default
        delete
        create
      end

      private

      attr_reader :resource

      def preprocess
        resource.preprocess if preprocess?
      end

      def preprocess?
        options.fetch(:preprocess)
      end

      def set_default
        remote.merge!(default: true) if default?
      end

      def delete
        local.delete if exists?
      end

      def create
        resource.local_model.create(remote)
      end

      def remote
        resource.adapted
      end

      def default?
        exists? && local.default?
      end

      def exists?
        !!local
      end

      def local
        resource.local
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        { preprocess: true }
      end
    end
  end
end
