module Troo
  class CreateComment
    def initialize(card, comment)
      @card    = card
      @comment = comment
    end

    def self.for(card, comment)
      new(card, comment).perform
    end

    def perform
      update_comments
    end

    private
    attr_reader :card, :comment

    def update_comments
      return Troo::CommentPersistence.for(parsed_json_response) if parsed_json_response
      false
    end

    def parsed_json_response
      if create_comment
        resource = OpenStruct.new(JSON.parse(create_comment))
        resource.member_creator_id = resource.memberCreator.fetch("id", "")
        resource
      else
        false
      end
    end

    def create_comment
      @comment_resource ||= Trello::Card.new.
        update_fields(attributes).add_comment(comment)
    rescue
      false
    end

    def attributes
      {
        'id' => card.external_card_id
      }
    end
  end
end
