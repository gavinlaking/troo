module Troo
  class CardPersistence
    include Persistence

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    private
    attr_reader :resource, :options

    def created
      Troo::Card.create(remote)
    end

    def local
      @local ||= Troo::Card.first(external_card_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::CardAdaptor.adapt(resource)
    end
  end
end
