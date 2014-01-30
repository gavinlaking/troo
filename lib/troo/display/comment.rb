module Troo
  class CommentDecorator
    include DecoratorHelpers

    def initialize(comment, options = {})
      @comment = comment
      @options = options
    end

    def as_view
      Template.parse(self, "/../views/comment.erb")
    end

    def member_username
      [comment.member.username, ":"].join
    end

    def text
      word_wrap(comment.text)
    end

    def date
      Time.parse(comment.date).strftime("%a, %b %d at %H:%M")
    end

    def id
      brackets(comment.id)
    end

    private
    attr_reader :comment
  end
end
