module Trlo
  class CreateComment
    def initialize(card_id)
      @card_id = card_id
    end

    def self.for(card_id)
      new(card_id).create_comment
    end

    def create_comment
      Trello::Card.find(card_id).add_comment(user_input)
    end

    private
    attr_reader :card_id

    def user_input
      Input.get(card_id)
    end
  end
end

