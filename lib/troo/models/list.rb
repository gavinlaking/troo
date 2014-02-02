module Troo
  class List < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :name
    attribute :position, Type::Integer
    attribute :default, Type::Boolean
    attribute :closed, Type::Boolean
    attribute :external_board_id
    attribute :external_list_id

    index :default
    index :external_board_id
    index :external_list_id

    alias_method :default?, :default

    def self.remote(id, options = { mode: :list })
      External::List.fetch(id, options).first
    end

    def board
      Retrieval::Board.retrieve(self.external_board_id)
    end

    def cards
      Troo::Card.find(external_list_id: self.external_list_id)
    end

    def decorator(options = {})
      Decorators::List.new(self, options)
    end

    def presenter(options = {})
      Presenters::List.new(self, options)
    end

    def set_default!
      SetDefault.for(self)
    end
  end
end
