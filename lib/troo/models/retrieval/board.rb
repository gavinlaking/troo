module Troo
  module Retrieval
    class Board < Resource
      class << self
        def all
          Troo::Board.all
        end
      end

      private

      def default
        Troo::Board.default
      end

      def by_id
        Troo::Board[id]
      end

      def by_external_id
        Troo::Board.first(external_board_id: id)
      end

      def remote
        Troo::Board.remote(id).first
      end
    end
  end
end
