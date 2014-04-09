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
      # @return [Remote::Comment]
      def remote
        Remote::Comment
      end

      # @return [Symbol]
      def type
        :comments
      end
    end

    # @return []
    def board
      Troo::Board.retrieve(external_board_id)
    end

    # @return []
    def card
      Troo::Card.retrieve(external_card_id)
    end

    # @return []
    def member
      Troo::Member.retrieve(external_member_id)
    end

    # @param  [Hash]
    # @return []
    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    # @return [FalseClass]
    def default?
      false
    end

    # @return [Symbol]
    def type
      self.class.type
    end
  end
end
