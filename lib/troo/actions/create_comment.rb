module Troo
  class CreateComment
    class << self
      def with(card, comment)
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

    attr_reader   :card, :comment
    attr_accessor :comment_resource

    def create_local
      return Persistence::Comment.for(resource) if create_remote
      false
    end

    def resource
      Remote::Comment.create(comment_resource)
    end

    def create_remote
      @comment_resource ||= Trello::Card.new
                              .update_fields(attributes)
                              .add_comment(comment)
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      false
    end

    def attributes
      { 'id' => card.external_card_id }
    end
  end
end
