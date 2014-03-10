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
        def remote_options
          { mode: :list }
        end

        def by_board_id
          {
            endpoint: :lists_by_board_id,
            query:    { filter: :open }
          }
        end

        def by_list_id
          { endpoint: :list_by_id }
        end
      end

      def associations
        []
      end

      def local_model
        Troo::List
      end

      def adapted
        {
          external_board_id: idBoard,
          external_list_id:  id,
          name:              name,
          position:          pos,
          closed:            closed
        }
      end
    end
  end
end
