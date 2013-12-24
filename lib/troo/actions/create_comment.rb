module Troo
  class CreateComment
    def initialize(card_id, comment = nil)
      @card_id = card_id
      @comment = comment
    end

    def self.for(card_id, comment = nil)
      new(card_id, comment).create
    end

    def create
      Trello::Card.new.
        update_fields({'id' => external_card_id}).
        add_comment(comment)
      self
    end

    def external_card_id
      card.external_card_id
    end

    private
    attr_reader :card_id

    def card
      @card ||= Troo::CardRetrieval.retrieve(card_id)
    end

    def comment
      @comment || user_input
    end

    def user_input
      Input.get(card_id)
    end
  end
end
