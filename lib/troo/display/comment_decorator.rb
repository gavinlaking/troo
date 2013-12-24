module Troo
  class CommentDecorator
    include DecoratorHelpers

    def initialize(comment)
      @comment = comment
    end

    def text
      comment.text
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
