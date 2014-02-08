module Troo
  module Adaptors
    class Board < Resource
      def adapted
        {
          external_board_id: external_board_id,
          name:              name,
          description:       description,
          closed:            closed,
        }
      end

      private

      def external_board_id
        resource.id
      end

      def name
        resource.name
      end

      def description
        resource.description
      end

      def closed
        resource.closed.to_s
      end
    end
  end
end
