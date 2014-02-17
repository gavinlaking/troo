module Troo
  module Adaptors
    class Comment < Resource
      def adapted
        {
          external_comment_id: resource.external_comment_id,
          external_board_id:   resource.external_board_id,
          external_card_id:    resource.external_card_id,
          external_member_id:  resource.external_member_id,
          date:                resource.date,
          text:                resource.text
        }
      end
    end
  end
end
