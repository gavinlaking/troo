module Troo
  class MemberDecorator
    include DecoratorHelpers

    def initialize(member)
      @member = member
    end

    def username
      brackets(member.username)
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
