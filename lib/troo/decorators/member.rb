module Troo
  module Decorators
    class Member < Resource
      include DecoratorHelpers

      def username
        ['@', klass.username].join
      end
    end
  end
end
