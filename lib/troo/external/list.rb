module Troo
  module External
    class List < Resource
      def persist
        Persistence::List.with_collection(fetch)
      end

      private

      def by_board_id
        Trello::Board.find(external_id).lists
      end

      def by_list_id
        [Trello::List.find(external_id)]
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
