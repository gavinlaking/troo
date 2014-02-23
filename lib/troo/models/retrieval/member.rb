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
        Troo::Member.by_external_id(id)
      end

      def remote
        Troo::Member.fetch(id).first
      end
    end
  end
end
