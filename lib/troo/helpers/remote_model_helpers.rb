module Troo
  module RemoteModelHelpers
    module ClassMethods
      def with_collection(resources = [])
        resources.map { |resource| new(resource) }
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def preprocess
      associations.map do |association|
        self.send(association).map { |record| record.preprocess }
      end

      Persistence::Resource.with_collection([self], preprocess: false)
    end

    def local
      @local ||= local_model.by_external_id(self.id)
    end

    def adapted
      @adapted ||= adaptor.adapt(self)
    end
  end
end
