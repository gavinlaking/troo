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
    attr_reader :resource

    def options
      defaults.merge!(@options)
    end

    def defaults
      { }
    end

    def created
      Troo.logger.debug "Local board does not exist, creating..."
      Troo::Board.create(resource_data)
    end

    def updated
      Troo.logger.debug "Local board out of date, updating..."
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      Troo.logger.debug "Local board identical, skipping..."
      local_data == resource_data
    end

    def local_exists?
      !!local
    end

    def local
      @local ||= Troo::Board.first(external_board_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_board_id: resource.id,
        name:              resource.name,
        description:       resource.description,
        closed:            resource.closed }
    end
  end
end
