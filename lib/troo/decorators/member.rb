module Troo
  module Decorators
    class Member < Resource
      include DecoratorHelpers

      # @return [String]
      def username
        ['@', klass.username].join
      end
    end
  end
end
