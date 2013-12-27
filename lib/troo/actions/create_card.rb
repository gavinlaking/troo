module Troo
  class CreateCard
    def initialize(list_id, name = nil, description = nil)
      @list_id     = list_id
      @name        = name
      @description = description
    end

    def self.for(list_id, name = nil, description = nil)
      new(list_id, name, description).perform
    end

    def perform
      update_cards
    end

    private
    attr_reader :list_id, :name, :description

    def update_cards
      return Troo::CardPersistence.for(create_card) if create_card
      false
    end

    def create_card
      @card ||= Trello::Card.create(attributes)
    rescue Trello::Error
      false
    end

    def list
      @list ||= Troo::ListRetrieval.retrieve(list_id)
    end

    def attributes
      {
        name:    name,
        list_id: list.external_list_id,
        desc:    description
      }
    end
  end
end
