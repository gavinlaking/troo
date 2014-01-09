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
      Troo::Board.create(resource_data)
    end

    def updated
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      return false if local_data != resource_data
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
