module Troo
  class MemberRetrieval
    def initialize(id)
      @id = id
    end

    def self.all
      Troo::Member.all
    end

    def self.retrieve(id)
      new(id).retrieve
    end

    def retrieve
      by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def by_id
      Troo::Member[id]
    end

    def by_external_id
      Troo::Member.first(external_member_id: id)
    end

    def remote
      ExternalMember.fetch(id, { mode: :member }).first
    end
  end
end
