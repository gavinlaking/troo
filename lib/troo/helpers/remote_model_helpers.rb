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
        associated(association).map { |record| record.preprocess }
      end

      Persistence::Resource.persist(self)
    end

    def local
      @local ||= local_model.by_external_id(self.id)
    end

    def adapted
      @adapted ||= adaptor.adapt(self)
    end

    private

    def associated(association)
      entity = self.send(association)
      return entity if entity.is_a?(Array)
      [entity]
    end
  end
end
