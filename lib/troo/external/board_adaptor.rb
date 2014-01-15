module Troo
  module External
    class BoardAdaptor
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
          name:              name,
          description:       description,
          closed:            closed,
        }
      end

      private
      attr_reader :resource

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
