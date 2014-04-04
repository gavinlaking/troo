module Troo
  module Remote
    class Board
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :name
      attribute :desc
      attribute :descData
      attribute :closed,        Boolean
      attribute :idOrganization
      attribute :pinned
      attribute :url
      attribute :shortUrl
      attribute :prefs
      attribute :labelNames
      attribute :lists,         Array[Troo::Remote::List]
      attribute :cards,         Array[Troo::Remote::Card]
      attribute :members,       Array[Troo::Remote::Member]

      class << self
        # @return []
        def remote_options
          { mode: :board }
        end

        # @return []
        def all
          {
            endpoint: :boards_all,
            query:    { filter: :open }
          }
        end

        # @return []
        def by_board_id
          {
            endpoint: :board_by_id,
            query:    {
                        cards:   :open,
                        lists:   :open,
                        members: :all
                      }
          }
        end
      end

      # @return []
      def associations
        [:lists, :cards, :members]
      end

      # @return []
      def local_model
        Troo::Board
      end

      # @return []
      def adapted
        {
          external_id: id,
          name:        name,
          description: desc,
          closed:      closed
        }
      end
    end
  end
end
