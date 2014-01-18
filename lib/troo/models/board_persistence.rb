module Troo
  class BoardPersistence
    include Persistence

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    private
    attr_reader :resource, :options

    def created
      Troo::Board.create(remote)
    end

    def local
      @local ||= Troo::Board.first(external_board_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::BoardAdaptor.adapt(resource)
    end
  end
end
