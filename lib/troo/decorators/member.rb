module Troo
  module Decorators
    class Member
      include DecoratorHelpers

      def initialize(member, options = {})
        @member  = member
        @options = options
      end

      def username
        ['@', member.username].join
      end

      def name
        member.full_name
      end

      def initials
        member.initials
      end

      private
      attr_reader :member
    end
  end
end
