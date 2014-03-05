module Troo
  module Decorators
    class Comment < Resource
      include DecoratorHelpers

      def as_view
        Template.parse(self, '/../views/comment.erb')
      end

      def member_username
        [klass.member.username, ':'].join
      end

      def text
        word_wrap(klass.text)
      end

      def date
        Time.parse(klass.date).strftime('%a, %b %d at %H:%M')
      end
    end
  end
end
