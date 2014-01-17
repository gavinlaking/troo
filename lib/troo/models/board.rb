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

    def lists
      Troo::List.find(external_board_id: self.external_board_id)
    end

    def cards
      Troo::Card.find(external_board_id: self.external_board_id)
    end
  end
end

