module Troo
  module Persistence
    class Local
      class << self
        # @param  resources [Array]
        # @return [Array]
        def with_collection(resources = [])
          resources.map do |resource|
            new(resource).preprocess
          end
        end

        # @param  resource []
        # @return [Array]
        def persist(resource)
          new(resource).persist
        end
      end

      # @param  resource []
      # @return [Troo::Persistence::Local]
      def initialize(resource)
        @resource = resource
      end

      # @return [Array]
      def preprocess
        resource.preprocess
      end

      # @return [Array]
      def persist
        set_default
        delete
        create
      end

      private

      attr_reader :resource

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
    end
  end
end
