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
    attr_reader :resource

    def options
      defaults.merge!(@options)
    end

    def defaults
      { debug: true }
    end

    def created
      Troo.logger.debug "Local card does not exist, creating..." if options[:debug]
      Troo::Card.create(resource_data)
    end

    def updated
      Troo.logger.debug "Local card out of date, updating..." if options[:debug]
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      Troo.logger.debug "Local card identical, skipping..." if options[:debug]
      local_data == resource_data
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
