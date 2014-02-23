module Troo
  module External
    class List < Resource
      private

      def all
        {}
      end

      def by_board_id
        {
          endpoint: :lists_by_board_id,
          query:    { filter: :open }
        }
      end

      def by_list_id
        { endpoint: :list_by_id }
      end

      def by_card_id
        {}
      end

      def by_member_id
        {}
      end

      def remote_model
        Remote::List
      end
    end
  end
end
