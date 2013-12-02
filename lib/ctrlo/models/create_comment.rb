module Ctrlo
  class CreateComment
    def initialize(card_id, comment = nil)
      @card_id = card_id
      @comment = comment
    end

    def self.for(card_id, comment = nil)
      new(card_id, comment).create
    end

    def create
      FindCard.with(card_id).add_comment(comment)
    end

    private
    attr_reader :card_id

    def comment
      @comment || user_input
    end

    def user_input
      Input.get(card_id)
    end
  end
end
