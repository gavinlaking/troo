module Troo
  class MemberRetrieval
    class << self
      def all
        Troo::Member.all
      end

      def retrieve(id)
        new(id).retrieve
      end
    end

    def initialize(id)
      @id = id
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
      External::Member.fetch(id, { mode: :member }).first
    end
  end
end
