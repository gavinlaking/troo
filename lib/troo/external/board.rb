module Troo
  module External
    class Board < Resource
      def persist
        return Persistence::Board.with_collection(resources) if any?
        []
      end

      private

      def all
        { endpoint: :boards_all }
      end

      def by_board_id
        { endpoint: :board_by_id }
      end

      def by_list_id
        {}
      end

      def by_card_id
        {}
      end

      def by_member_id
        {}
      end

      def model
        Remote::Board
      end
    end
  end
end
