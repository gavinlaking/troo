module Troo
  module Retrieval
    class Comment < Resource
      class << self
        def all
          Troo::Comment.all
        end
      end

      private

      def by_id
        Troo::Comment[id]
      end

      def by_external_id
        Troo::Comment.by_external_id(id)
      end

      def remote
        nil
      end
    end
  end
end
