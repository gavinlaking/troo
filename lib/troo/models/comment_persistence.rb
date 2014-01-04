module Troo
  class CommentPersistence

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
      Troo.logger.debug "Local comment does not exist, creating..." if options[:debug]
      Troo::Comment.create(resource_data)
    end

    def updated
      Troo.logger.debug "Local comment out of date, updating..." if options[:debug]
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      return false if local_data != resource_data
      Troo.logger.debug "Local comment identical, skipping..." if options[:debug]
      true
    end

    def local_exists?
      !!local
    end

    def local
      @local ||= Troo::Comment.first(external_comment_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_comment_id: resource.id,
        external_board_id:   resource.data.fetch("board", {}).fetch("id", ""),
        external_card_id:    resource.data.fetch("card",  {}).fetch("id", ""),
        external_member_id:  resource.member_creator_id,
        date:                resource.date.to_s,
        text:                resource.data.fetch("text", "") }
    end
  end
end
