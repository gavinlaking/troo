module Troo
  class BoardPersistence

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    def self.for(resource, options = {})
      new(resource, options).persist
    end

    def persist
      return local   if local_identical?
      return updated if local_exists?
      return created
    end

    private
    attr_reader :resource, :options

    def created
      Troo::Board.create(remote)
    end

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

    def local
      @local ||= Troo::Board.first(external_board_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::BoardAdaptor.adapt(resource)
    end
  end
end
