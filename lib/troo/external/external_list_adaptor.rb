module Troo
  module External
    class ListAdaptor
      class << self
        def adapt(resource)
          new(resource).adapted
        end
      end

      def initialize(resource)
        @resource = resource
      end

      def adapted
        {
          external_board_id: external_board_id,
          external_list_id:  external_list_id,
          name:              name,
          position:          position,
          closed:            closed,
        }
      end

      private
      attr_reader :resource

      def external_board_id
        resource.board_id
      end

      def external_list_id
        resource.id
      end

      def name
        resource.name
      end

      def position
        resource.pos.to_s
      end

      def closed
        resource.closed.to_s
      end
    end
  end
end
