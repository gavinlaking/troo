module Troo
  module Retrieval
    class Member < Resource
      class << self
        def all
          Troo::Member.all
        end
      end

      private

      def by_id
        Troo::Member[id]
      end

      def by_external_id
        Troo::Member.first(external_member_id: id)
      end

      def remote
        Troo::Member.remote(id)
      end
    end
  end
end
