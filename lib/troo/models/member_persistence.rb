module Troo
  class MemberPersistence
    include Persistence

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    private
    attr_reader :resource, :options

    def created
      Troo::Member.create(remote)
    end

    def local
      @local ||= Troo::Member.first(external_member_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::MemberAdaptor.adapt(resource)
    end
  end
end
