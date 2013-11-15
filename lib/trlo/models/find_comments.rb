module Trlo
  class FindComments
    def initialize(card_id)
      @card_id = card_id
    end

    def self.for(card_id)
      new(card_id).all_comments
    end

    def all_comments
      get_comments.map do |comment|
        Comment.decorate(comment)
      end
    end

    private
    attr_reader :card_id

    def get_comments
      Trello::Card.find(card_id).actions.collect   { |a| a if is_comment?(a) }.
                                         delete_if { |a| a.nil? }
    end

    def is_comment?(a)
      a.type == "commentCard"
    end
  end
end
