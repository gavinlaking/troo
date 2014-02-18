module Troo
  class CreateCard
    class << self
      def with(list, name = nil, description = nil)
        new(list, name, description).perform
      end
    end

    def initialize(list, name = nil, description = nil)
      @list        = list
      @name        = name
      @description = description
    end

    def perform
      create_local
    end

    private

    attr_reader :list, :name, :description

    def create_local
      return Persistence::Card.for(create_remote) if create_remote
      false
    end

    def create_remote
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
