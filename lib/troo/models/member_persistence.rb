module Troo
  class MemberPersistence

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
      Troo::Member.create(resource_data)
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
      @local ||= Troo::Member.first(external_member_id: resource.id)
    end

    def local_data
      local.external_attributes
    end

    def resource_data
      { external_member_id: resource.id,
        username:           resource.username,
        email:              resource.email,
        full_name:          resource.full_name,
        initials:           resource.initials,
        avatar_id:          resource.avatar_id,
        bio:                resource.bio,
        url:                resource.url }
    end
  end
end
