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

    attr_reader :card, :comment

    def create_local
      return Persistence::Comment.with_collection(resource) if resource
      false
    end

    def resource
      @resource ||= API::Client.perform(parameters)
    end

    def parameters
      {
        verb:          :post,
        endpoint:      :create_comment,
        interpolation: interpolation,
        query:         query,
        model:         Remote::Comment
      }
    end

    def interpolation
      { external_id: card.external_card_id }
    end

    def query
      { text: comment }
    end
  end
end
