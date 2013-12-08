module Ctrlo
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
      Ctrlo::Comment.create(resource_data)
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
      @local ||= Ctrlo::Comment.first(external_comment_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_comment_id: resource.id,
        external_board_id:   resource.data["board"]["id"],
        external_card_id:    resource.data["card"]["id"],
        external_member_id:  resource.member_creator_id,
        date:                resource.date,
        text:                resource.data["text"] }
    end
  end
end
