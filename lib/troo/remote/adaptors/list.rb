module Troo
  module Remote
    module Adaptors
      class List < Resource
        def adapted
          {
            external_board_id: resource.idBoard,
            external_list_id:  resource.id,
            name:              resource.name,
            position:          resource.pos,
            closed:            resource.closed
          }
        end
      end
    end
  end
end
