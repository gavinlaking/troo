module Troo
  class CardPersistence < Resource
    private

    def created
      Troo::Card.create(remote_data)
    end

    def local
      @local ||= Troo::Card.first(external_card_id: resource.id)
    end

    def remote_data
      @remote ||= Troo::External::CardAdaptor.adapt(resource)
    end
  end
end
