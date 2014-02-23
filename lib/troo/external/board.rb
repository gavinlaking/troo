module Troo
  module External
    class Board < Resource
      private

      def all
        {
          endpoint: :boards_all,
          query:    { filter: :open }
        }
      end

      def by_board_id
        {
          endpoint: :board_by_id,
          query:    {
                      cards:   :open,
                      lists:   :open,
                      members: :all
                    }
        }
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

      def remote_model
        Remote::Board
      end
    end
  end
end
