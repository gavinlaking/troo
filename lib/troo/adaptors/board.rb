module Troo
  module Adaptors
    class Board < Resource
      def adapted
        {
          external_board_id: resource.id,
          name:              resource.name,
          description:       resource.description,
          closed:            resource.closed
        }
      end
    end
  end
end
