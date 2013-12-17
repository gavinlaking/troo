module Troo
  class CommentDecorator
    def initialize(comment)
      @comment = comment
    end

    def text
      comment.text
    end

    def date
      comment.date.strftime("%a, %b %d at %H:%M")
    end

    def id
      brackets(comment.id)
    end

    private
    attr_reader :comment

    def brackets(value)
      "(#{value})"
    end
  end
end
