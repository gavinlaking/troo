module Troo
  class MemberPersistence < Resource
    private

    def created
      Troo::Member.create(remote_data)
    end

    def local
      @local ||= Troo::Member.first(external_member_id: resource.id)
    end

    def remote_data
      @remote ||= Troo::External::MemberAdaptor.adapt(resource)
    end
  end
end
