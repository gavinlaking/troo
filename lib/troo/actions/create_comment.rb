module Troo
  class CreateComment
    def initialize(card_id, comment)
      @card_id = card_id
      @comment = comment
    end

    def self.for(card_id, comment)
      new(card_id, comment).perform
    end

    def perform
      update_comments
    end

    private
    attr_reader :card_id, :comment

    def update_comments
      return Troo::CommentPersistence.for(create_comment) if create_comment
      false
    end

    def create_comment
      @comment_resource ||= Trello::Card.new.
        update_fields(attributes).add_comment(comment)
    rescue
      false
    end

    def card
      @card ||= Troo::CardRetrieval.retrieve(card_id)
    end

    def attributes
      {
        'id' => card.external_card_id
      }
    end
  end
end
