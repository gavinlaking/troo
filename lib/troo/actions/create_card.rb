module Troo
  class CreateCard
    def initialize(list_id, name = nil, description = nil)
      @list_id     = list_id
      @name        = name
      @description = description
    end

    def self.for(list_id, name = nil, description = nil)
      new(list_id, name, description).create
    end

    def create
      Trello::Card.create(attributes)
      self
    end

    def list_name
      list.name
    end

    def external_list_id
      list.external_list_id
    end

    def name
      @name ||= name_input
    end

    def description
      @description ||= description_input
    end

    private
    attr_reader :list_id

    def list
      @list ||= Troo::ListRetrieval.retrieve(list_id)
    end

    def attributes
      {
        name:    name,
        list_id: external_list_id,
        desc:    description
      }
    end

    def name_input
      Input.get(list_id)
    end

    def description_input
      Input.get(list_id)
    end
  end
end
