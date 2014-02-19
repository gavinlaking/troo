module Troo
  module Adaptors
    class List < Resource
      def adapted
        {
          external_board_id: resource.external_board_id,
          external_list_id:  resource.id,
          name:              resource.name,
          position:          resource.pos,
          closed:            resource.closed
        }
      end
    end
  end
end
