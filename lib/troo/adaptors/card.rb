module Troo
  module Adaptors
    class Card < Resource
      def adapted
        {
          external_board_id:   external_board_id,
          external_list_id:    external_list_id,
          external_card_id:    external_card_id,
          external_member_ids: external_member_ids,
          short_id:            short_id,
          name:                name,
          desc:                desc,
          url:                 url,
          position:            position,
          last_activity_date:  last_activity_date,
          closed:              closed,
        }
      end

      private

      def external_board_id
        resource.board_id
      end

      def external_list_id
        resource.list_id
      end

      def external_card_id
        resource.id
      end

      def external_member_ids
        resource.member_ids.to_s.gsub(" ", "")
      end

      def short_id
        resource.short_id.to_s
      end

      def name
        resource.name
      end

      def desc
        resource.desc
      end

      def url
        resource.url
      end

      def position
        resource.pos.to_s
      end

      def last_activity_date
        resource.last_activity_date.to_s
      end

      def closed
        resource.closed.to_s
      end
    end
  end
end
