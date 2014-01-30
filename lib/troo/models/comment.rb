module Troo
  class Comment < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :text
    attribute :date
    attribute :external_board_id
    attribute :external_card_id
    attribute :external_comment_id
    attribute :external_member_id

    index :date
    index :external_board_id
    index :external_card_id
    index :external_comment_id
    index :external_member_id

    def board
      BoardRetrieval.retrieve(self.external_board_id)
    end

    def card
      CardRetrieval.retrieve(self.external_card_id)
    end

    def member
      MemberRetrieval.retrieve(self.external_member_id)
    end

    def decorator(options = {})
      Decorators::Comment.new(self, options)
    end
  end
end
