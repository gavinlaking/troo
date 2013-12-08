module Ctrlo
  class CommentDecorator
    def initialize(comment)
      @comment = comment
    end

    def as_view
      Template.parse(self, "/comment_decorator.erb")
    end

    def member_username
      if comment.member && comment.member.username
        comment.member.username
      else
        "Unknown"
      end
    end

    def text
      comment.text
    end

    def date
      comment.date.strftime("%a, %b %d at %H:%M")
    end

    private
    attr_reader :comment
  end
end
