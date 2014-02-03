module Troo
  module Adaptors
    class Comment < Resource
      def adapted
        {
          external_comment_id: external_comment_id,
          external_board_id:   external_board_id,
          external_card_id:    external_card_id,
          external_member_id:  external_member_id,
          date:                date,
          text:                text,
        }
      end

      private

      def external_comment_id
        resource.id
      end

      def external_board_id
        resource.data.fetch("board", {}).fetch("id", "")
      end

      def external_card_id
        resource.data.fetch("card",  {}).fetch("id", "")
      end

      def external_member_id
        resource.member_creator_id
      end

      def date
        resource.date.to_s
      end

      def text
        resource.data.fetch("text", "")
      end
    end
  end
end
