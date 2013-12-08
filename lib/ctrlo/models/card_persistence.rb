module Ctrlo
  class CardPersistence

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
      Ctrlo::Card.create(resource_data)
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
      @local ||= Ctrlo::Card.first(external_card_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_board_id:   resource.board_id,
        external_list_id:    resource.list_id,
        external_card_id:    resource.id,
        external_member_ids: resource.member_ids,
        short_id:            resource.short_id,
        name:                resource.name,
        desc:                resource.desc,
        url:                 resource.url,
        position:            resource.pos,
        last_activity_date:  resource.last_activity_date,
        closed:              resource.closed }
    end
  end
end
