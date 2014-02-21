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
  end
end
