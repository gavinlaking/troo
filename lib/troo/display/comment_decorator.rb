module Troo
  class CommentDecorator
    include DecoratorHelpers

    def initialize(comment, options = {})
      @comment = comment
      @options = options
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

    def options
      defaults.merge!(@options)
    end

    def defaults
      { ansicolor: true }
    end
  end
end
