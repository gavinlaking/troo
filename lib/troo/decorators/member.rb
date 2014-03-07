module Troo
  module Decorators
    class Member < Resource
      include DecoratorHelpers

      def name
        klass.full_name
      end

      def initials
        klass.initials
      end

      def username
        ['@', klass.username].join
      end
    end
  end
end
