module Troo
  module Remote
    module Retrieval
      class Comment < Resource
        private

        def all
          {}
        end

        def by_board_id
          {
            endpoint: :comments_by_board_id,
            query:    { filter: :commentCard }
          }
        end

        def by_list_id
          {}
        end

        def by_card_id
          {
            endpoint: :comments_by_card_id,
            query:    { filter: :commentCard }
          }
        end

        def by_member_id
          {}
        end

        def remote_model
          Remote::Comment
        end
      end
    end
  end
end
