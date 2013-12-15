module Troo
  class Card < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :short_id
    attribute :name
    attribute :desc
    attribute :url
    attribute :external_member_ids, Type::Array
    attribute :position
    attribute :last_activity_date
    attribute :current, Type::Boolean
    attribute :closed, Type::Boolean
    attribute :external_board_id
    attribute :external_list_id
    attribute :external_card_id

    index :current
    index :external_board_id
    index :external_list_id
    index :external_card_id

    def board
      Troo::Board.first(external_board_id: self.external_board_id)
    end

    def list
      Troo::List.first(external_list_id: self.external_list_id)
    end

    def comments
      Troo::Comment.find(external_card_id: self.external_card_id)
    end

    def members
      #Troo::Member.find(external_member_id:) # we need to get all the member ids for the card first
    end
  end
end

