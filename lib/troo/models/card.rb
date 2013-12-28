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

    index :short_id
    index :current
    index :external_board_id
    index :external_list_id
    index :external_card_id

    alias_method :current?, :current

    def board
      Troo::Board.first(external_board_id: self.external_board_id)
    end

    def list
      Troo::List.first(external_list_id: self.external_list_id)
    end

    def comments
      Troo::Comment.find(external_card_id: self.external_card_id)
    end

    def recent_comments
      comments.sort(by: :date, limit: [0, 3])
    end

    def members
      if external_member_ids.any?
        m = external_member_ids.map do |external_member_id|
          Troo::Member.first(external_member_id: external_member_id)
        end.compact
      else
        []
      end
    end
  end
end

