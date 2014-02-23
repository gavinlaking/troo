module Troo
  module Remote
    module Retrieval
      class Member < Resource
        private

        def all
          {}
        end

        def by_board_id
          {
            endpoint: :members_by_board_id,
            query:    { filter: :all }
          }
        end

        def by_list_id
          {}
        end

        def by_card_id
          {}
        end

        def by_member_id
          { endpoint: :member_by_id }
        end

        def remote_model
          Remote::Member
        end
      end
    end
  end
end