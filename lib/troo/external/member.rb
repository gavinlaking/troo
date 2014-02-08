module Troo
  module External
    class Member < Resource
      def persist
        Persistence::Member.with_collection(fetch)
      end

      private

      def by_board_id
        Trello::Board.find(external_id).members
      end

      def by_list_id
        []
      end

      def by_card_id
        []
      end

      def by_member_id
        [Trello::Member.find(external_id)]
      end
    end
  end
end
