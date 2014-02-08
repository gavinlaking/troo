module Troo
  class Board < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :name
    attribute :description
    attribute :default, Type::Boolean
    attribute :closed, Type::Boolean
    attribute :external_board_id

    index :default
    index :external_board_id

    alias_method :default?, :default

    def self.remote(id, options = {})
      External::Board.fetch(id, options).first
    end

    def lists
      Troo::List.find(external_board_id: self.external_board_id)
    end

    def cards
      Troo::Card.find(external_board_id: self.external_board_id)
    end

    def decorator(options = {})
      Decorators::Board.new(self, options)
    end

    def presenter(options = {})
      Presenters::Board.new(self, options)
    end

    def set_default!
      Behaviours::SetDefault.for(self)
    end
  end
end
