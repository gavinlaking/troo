module Trlo
  class Member
    def initialize(member)
      @member = member
    end

    def self.decorate(member)
      new(member).decorate
    end

    def decorate
      { id: id, full_name: full_name, username: username }
    end

    def username
      member.username
    end

    def full_name
      member.full_name
    end

    def id
      member.id
    end

    private
    attr_reader :member
  end

  class FindMember
    def initialize(member_id)
      @member_id = member_id
    end

    def self.with(member_id)
      new(member_id).find
    end

    def find
      Trello::Member.find(member_id)
    end

    private
    attr_reader :member_id
  end
end

