module Troo
  module External
    class Card < Resource
      def persist
        Persistence::Card.with_collection(fetch)
      end

      private

      def defaults
        { comments: true, mode: :board }
      end

      def by_board_id
        Trello::Board.find(external_id).cards
      end

      def by_list_id
        Trello::List.find(external_id).cards
      end

      def by_card_id
        [Trello::Card.find(external_id)]
      end

      def by_member_id
        []
      end
    end
  end
end
