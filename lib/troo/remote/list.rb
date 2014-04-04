module Troo
  module Remote
    class List
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :name
      attribute :closed,  Boolean
      attribute :idBoard
      attribute :pos,     Integer

      class << self
        # @return []
        def remote_options
          { mode: :list }
        end

        # @return []
        def by_board_id
          {
            endpoint: :lists_by_board_id,
            query:    { filter: :open }
          }
        end

        # @return []
        def by_list_id
          { endpoint: :list_by_id }
        end
      end

      # @return []
      def associations
        []
      end

      # @return []
      def local_model
        Troo::List
      end

      # @return []
      def adapted
        {
          external_board_id: idBoard,
          external_id:       id,
          name:              name,
          position:          pos,
          closed:            closed
        }
      end
    end
  end
end
