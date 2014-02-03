module Troo
  class CreateComment
    class << self
      def for(card, comment)
        new(card, comment).perform
      end
    end

    def initialize(card, comment)
      @card    = card
      @comment = comment
    end

    def perform
      create_local
    end

    private
    attr_reader :card, :comment

    def create_local
      return Persistence::Comment.for(parsed_json_response) if parsed_json_response
      false
    end

    def parsed_json_response
      return false unless create_remote
      resource = OpenStruct.new(JSON.parse(create_remote))
      resource.member_creator_id = resource.memberCreator.fetch("id", "")
      resource
    end

    def create_remote
      @comment_resource ||= Trello::Card.new.
        update_fields(attributes).add_comment(comment)
    rescue
      false
    end

    def attributes
      { 'id' => card.external_card_id }
    end
  end
end
