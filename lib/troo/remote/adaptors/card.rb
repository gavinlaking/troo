module Troo
  module Remote
    module Adaptors
      class Card < Resource
        def adapted
          {
            short_id:            resource.idShort,
            name:                resource.name,
            desc:                resource.desc,
            url:                 resource.url,
            position:            resource.pos,
            last_activity_date:  resource.dateLastActivity,
            closed:              resource.closed
          }.merge!(external_ids)
        end

        private

        def external_ids
          {
            external_board_id:   resource.idBoard,
            external_list_id:    resource.idList,
            external_card_id:    resource.id,
            external_member_ids: resource.idMembers
          }
        end
      end
    end
  end
end
