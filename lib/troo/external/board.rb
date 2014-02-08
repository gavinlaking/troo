module Troo
  module External
    class Board < Resource
      def persist
        Persistence::Board.with_collection(fetch)
      end

      private

      def all_boards
        Trello::Board.all
      end

      def by_board_id
        [Trello::Board.find(external_id)]
      end

      def by_list_id
        []
      end

      def by_card_id
        []
      end

      def by_member_id
        []
      end
    end
  end
end
