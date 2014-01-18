module Troo
  class ListPersistence
    include Persistence

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    private
    attr_reader :resource, :options

    def created
      Troo::List.create(remote)
    end

    def local
      @local ||= Troo::List.first(external_list_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::ListAdaptor.adapt(resource)
    end
  end
end
