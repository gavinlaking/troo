module Troo
  module Remote
    module Adaptors
      class Comment < Resource
        def adapted
          {
            external_comment_id: resource.id,
            external_board_id:   resource.data.board.id,
            external_card_id:    resource.data.card.id,
            external_member_id:  resource.idMemberCreator,
            date:                resource.date,
            text:                resource.text
          }
        end
      end
    end
  end
end
