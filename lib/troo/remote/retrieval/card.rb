module Troo
  module Remote
    module Retrieval
      class Card < Resource
        private

        def all
          {}
        end

        def by_board_id
          {
            endpoint: :cards_by_board_id,
            query:    { filter: :open }
          }
        end

        def by_list_id
          {
            endpoint: :cards_by_list_id,
            query:    { filter: :open }
          }
        end

        def by_card_id
          {
            endpoint: :card_by_id,
            query:    { actions: :commentCard }
          }
        end

        def by_member_id
          {}
        end

        def remote_model
          Remote::Card
        end
      end
    end
  end
end
