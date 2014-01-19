module Troo
  class CreateCard
    class << self
      def for(list, name = nil, description = nil)
        new(list, name, description).perform
      end
    end

    def initialize(list, name = nil, description = nil)
      @list        = list
      @name        = name
      @description = description
    end

    def perform
      update_cards
    end

    private
    attr_reader :list, :name, :description

    def update_cards
      return CardPersistence.for(create_card) if create_card
      false
    end

    def create_card
      @card ||= Trello::Card.create(attributes)
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      false
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
