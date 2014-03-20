module Troo
  class Comment < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :text
    attribute :date
    attribute :external_board_id
    attribute :external_card_id
    attribute :external_id
    attribute :external_member_id
    attribute :short_id

    index :date
    index :external_board_id
    index :external_card_id
    index :external_id
    index :external_member_id
    index :short_id

    class << self
      def remote
        Remote::Comment
      end

      def type
        :comments
      end
    end

    def board
      Troo::Board.retrieve(external_board_id)
    end

    def card
      Troo::Card.retrieve(external_card_id)
    end

    def member
      Troo::Member.retrieve(external_member_id)
    end

    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    def default?
      false
    end

    def type
      self.class.type
    end
  end
end
