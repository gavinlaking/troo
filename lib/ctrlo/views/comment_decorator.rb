module Ctrlo
  class CommentDecorator
    def initialize(comment)
      @comment = comment
    end

    def self.decorate(comment)
      new(comment).decorate
    end

    def decorate
      Template.parse(self)
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

    def template_file
      "/comment_decorator.erb"
    end

    private
    attr_reader :comment
  end
end
