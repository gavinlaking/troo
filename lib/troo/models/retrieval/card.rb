module Troo
  module Retrieval
    class Card < Resource
      class << self
        def all
          Troo::Card.all
        end
      end

      private

      def default
        Troo::Card.default
      end

      def by_id
        Troo::Card[id]
      end

      def by_short_id
        Troo::Card.first(short_id: id)
      end

      def by_external_id
        Troo::Card.by_external_id(id)
      end

      def remote
        Troo::Card.fetch(id).first
      end
    end
  end
end
