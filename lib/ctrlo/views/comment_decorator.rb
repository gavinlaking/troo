module Ctrlo
  class CommentDecorator
    def initialize(comment = nil)
      @comment = comment
    end

    def self.decorate(comment = nil)
      new(comment).decorate
    end

    def decorate
      Template.parse(self)
    end

    def member_username
      return comment.member_username unless comment.member_username.empty?
      "Unknown"
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
