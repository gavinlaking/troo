module Troo
  module Persistence
    module ClassMethods
      def for(resource, options = {})
        new(resource, options).persist
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def persist
      return local   if local_identical?
      return updated if local_exists?
      return created
    end

    private

    def updated
      local.update(remote) && local
    end

    def local_identical?
      return false unless local_exists?
      return false if local_data != remote
      true
    end

    def local_data
      local.external_attributes
    end

    def local_exists?
      !!local
    end
  end
end
