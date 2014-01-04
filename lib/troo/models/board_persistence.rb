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
      { debug: true }
    end

    def created
      Troo.logger.debug "Local board does not exist, creating..." if options[:debug]
      Troo::Board.create(resource_data)
    end

    def updated
      Troo.logger.debug "Local board out of date, updating..." if options[:debug]
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      return false if local_data != resource_data
      Troo.logger.debug "Local board identical, skipping..." if options[:debug]
      true
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
        closed:            resource.closed.to_s }.delete_if { |k, v| v.nil? }
    end
  end
end
