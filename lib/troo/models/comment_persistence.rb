module Troo
  class CommentPersistence

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
      Troo::Comment.create(resource_data)
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
        date:                resource.date,
        text:                resource.data.fetch("text", "") }
    end
  end
end
