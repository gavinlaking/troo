module Troo
  class ListPersistence < Resource
    private

    def created
      Troo::List.create(remote_data)
    end

    def local
      @local ||= Troo::List.first(external_list_id: resource.id)
    end

    def remote_data
      @remote ||= Troo::External::ListAdaptor.adapt(resource)
    end
  end
end
