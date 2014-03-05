module Troo
  module Decorators
    class Member < Resource
      include DecoratorHelpers

      def username
        ['@', klass.username].join
      end

      def name
        klass.full_name
      end

      def initials
        klass.initials
      end
    end
  end
end
