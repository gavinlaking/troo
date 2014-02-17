module Troo
  module Adaptors
    class Card < Resource
      def adapted
        {
          external_board_id:   resource.external_board_id,
          external_list_id:    resource.external_list_id,
          external_card_id:    resource.external_card_id,
          external_member_ids: resource.external_member_ids,
          short_id:            resource.short_id,
          name:                resource.name,
          desc:                resource.desc,
          url:                 resource.url,
          position:            resource.position,
          last_activity_date:  resource.last_activity_date,
          closed:              resource.closed
        }
      end
    end
  end
end
