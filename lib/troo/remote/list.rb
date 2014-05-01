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
        # @return [Hash]
        def remote_options
          { mode: :list }
        end

        # @return [Hash]
        def by_board_id
          {
            endpoint: :lists_by_board_id,
            query:    { filter: :open }
          }
        end

        # @return [Hash]
        def by_list_id
          { endpoint: :list_by_id }
        end
      end

      # @return [Array]
      def associations
        []
      end

      # @return [Class]
      def local_model
        Troo::List
      end

      # @return [Hash]
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
