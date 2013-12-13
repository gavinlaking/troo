module Troo
  class ListPersistence

    def initialize(resource)
      @resource = resource
    end

    def self.for(resource)
      new(resource).persist
    end

    def persist
      return local   if local_identical?
      return updated if local_exists?
      return created
    end

    private
    attr_reader :resource

    def created
      Troo::List.create(resource_data)
    end

    def updated
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      local_data == resource_data
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
        position:          resource.pos,
        closed:            resource.closed }
    end
  end
end
