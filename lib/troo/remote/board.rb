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
        def remote_options
          { mode: :board }
        end

        def all
          {
            endpoint: :boards_all,
            query:    { filter: :open }
          }
        end

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

        def by_list_id
          {}
        end

        def by_card_id
          {}
        end

        def by_member_id
          {}
        end
      end

      def associations
        [:lists, :cards, :members]
      end

      def local_model
        Troo::Board
      end

      def adaptor
        Adaptors::Board
      end

      def remote_retrieval

      end
    end
  end
end
