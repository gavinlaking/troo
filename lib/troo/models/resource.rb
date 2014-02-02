module Troo
  class Resource
    attr_reader :resource, :options

    class << self
      def for(resource, options = {})
        new(resource, options).persist
      end
    end

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    def persist
      return local   if local_identical?
      return updated if local_exists?
      return created
    end

    private

    def updated
      local.update(remote_data) && local
    end

    def local_identical?
      return false unless local_exists?
      return false if local_data != remote_data
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
