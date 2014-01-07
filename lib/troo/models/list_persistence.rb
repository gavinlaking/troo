module Troo
  class ListPersistence

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
      Troo::List.create(resource_data)
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
      @local ||= Troo::List.first(external_list_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_board_id: resource.board_id,
        external_list_id:  resource.id,
        name:              resource.name,
        position:          resource.pos.to_s,
        closed:            resource.closed.to_s }.delete_if { |k, v| v.nil? }
    end
  end
end
