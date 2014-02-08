module Troo
  module External
    class Comment < Resource
      def persist
        Persistence::Comment.with_collection(fetch)
      end

      private

      def by_board_id
        Trello::Board.find(external_id).actions(filter: 'commentCard')
      end

      def by_list_id
        Trello::List.find(external_id).actions(filter: 'commentCard')
      end

      def by_card_id
        Trello::Card.find(external_id).actions(filter: 'commentCard')
      end

      def by_member_id
        []
      end
    end
  end
end
