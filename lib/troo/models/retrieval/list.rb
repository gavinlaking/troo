module Troo
  module Retrieval
    class List < Resource
      class << self
        def all
          Troo::List.all
        end
      end

      private

      def default
        Troo::List.default
      end

      def by_id
        Troo::List[id]
      end

      def by_external_id
        Troo::List.first(external_list_id: id)
      end

      def remote
        Troo::List.remote(id)
      end
    end
  end
end
