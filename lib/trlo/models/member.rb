module Trlo
  class Member
    def initialize(member)
      @member = member
    end

    def self.decorate(member)
      new(member).decorate
    end

    def decorate
      { id: id, name: name, username: username }
    end

    def username
      member.username
    end

    def name
      member.full_name
    end

    def id
      member.id
    end

    private
    attr_reader :member
  end
end

