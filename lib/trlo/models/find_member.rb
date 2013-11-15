module Trlo
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
