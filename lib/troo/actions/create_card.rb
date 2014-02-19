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
      return Persistence::Card.with_collection(resource).first if resource
      false
    end

    def resource
      @resource ||= API::Client.perform(parameters)
    end

    def parameters
      {
        verb:          :post,
        endpoint:      :create_card,
        interpolation: {},
        query:         query,
        model:         Remote::Card
      }
    end

    def query
      {
        name:    name,
        list_id: list.external_list_id,
        desc:    description
      }
    end
  end
end
