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
      data.fetch("text", "")
    end

    def date
      comment.date.to_s
    end

    private
    attr_reader :comment

    def data
      comment.data
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

