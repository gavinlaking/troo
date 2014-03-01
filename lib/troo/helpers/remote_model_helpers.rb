module Troo
  module RemoteModelHelpers
    module ClassMethods
      def with_collection(resources = [])
        resources.map { |resource| new(resource) }
      end
    end

    module InstanceMethods
      def preprocess
        associations.map do |association|
          associated(association).map { |record| record.preprocess }
        end

        Persistence::Local.persist(self)
      end

      def local
        @local ||= local_model.by_external_id(self.id)
      end

      def adapted
        @adapted ||= adaptor.adapt(self)
      end

      private

      def associated(association)
        Array(self.send(association))
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end
