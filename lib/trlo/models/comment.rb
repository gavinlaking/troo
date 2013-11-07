module Trlo
  class Comment
    def initialize(comment)
      @comment = comment
    end

    def self.decorate(comment)
      new(comment).decorate
    end

    def decorate
      { member: member, text: text, date: date }
    end

    def member
      comment.member_creator_id
    end

    def text
      data.fetch["text", ""]
    end

    def date
      comment.date
    end

    private
    attr_reader :comment

    def data
      comment.data
    end
  end

  class FindComment
    def initialize(comment_id)
      @comment_id = comment_id
    end

    def self.with(comment_id)
      new(comment_id).find
    end

    def find
      Trello::Comment.find(comment_id)
    end

    private
    attr_reader :comment_id
  end

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
      FindCard.with(card_id).actions.collect   { |a| a if is_comment?(a) }.
                                     delete_if { |a| a.nil? }
    end

    def is_comment?(a)
      a.type == "commentCard"
    end
  end

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
