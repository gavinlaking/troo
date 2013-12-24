module Troo
  class MemberPersistence

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
      { }
    end

    def created
      Troo.logger.debug "Local member does not exist, creating..."
      Troo::Member.create(resource_data)
    end

    def updated
      Troo.logger.debug "Local member out of date, updating..."
      local.update(resource_data) && local
    end

    def local_identical?
      return false unless local_exists?
      Troo.logger.debug "Local member identical, skipping..."
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
