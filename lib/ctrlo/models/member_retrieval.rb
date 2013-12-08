module Ctrlo
  class MemberRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      all || by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def all
      return all_members unless id
      nil
    end

    def all_members
      Ctrlo::Member.all
    end

    def by_id
      Ctrlo::Member.get(id)
    end

    def by_external_id
      Ctrlo::Member.first(external_member_id: id)
    end

    def remote
      ExternalMember.fetch(id, { mode: :member }).first
    end
  end
end
