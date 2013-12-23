module Troo
  class MemberDecorator
    include DecoratorHelpers

    def initialize(member, options = {})
      @member = member
      @options = options
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

    def options
      defaults.merge!(@options)
    end

    def defaults
      { ansicolor: true }
    end
  end
end
