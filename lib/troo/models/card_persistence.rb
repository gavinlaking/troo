module Troo
  class CardPersistence

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
      Troo::Card.create(resource_data)
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
      @local ||= Troo::Card.first(external_card_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_board_id:   resource.board_id,
        external_list_id:    resource.list_id,
        external_card_id:    resource.id,
        external_member_ids: resource.member_ids.to_s.gsub(" ", ""),
        short_id:            resource.short_id.to_s,
        name:                resource.name,
        desc:                resource.desc,
        url:                 resource.url,
        position:            resource.pos.to_s,
        last_activity_date:  resource.last_activity_date.to_s,
        closed:              resource.closed.to_s }.delete_if { |k, v| v.nil? }
    end
  end
end
