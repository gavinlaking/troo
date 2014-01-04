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

    def board
      Troo::Board.first(external_board_id: self.external_board_id)
    end

    def cards
      Troo::Card.find(external_list_id: self.external_list_id)
    end
  end
end
