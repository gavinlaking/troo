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
end

