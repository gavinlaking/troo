module Troo
  module Remote
    class Card
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :badges
      attribute :checkItemStates
      attribute :closed,                Boolean
      attribute :dateLastActivity
      attribute :desc
      attribute :descData
      attribute :due
      attribute :idBoard
      attribute :idChecklists
      attribute :idList
      attribute :idMembers
      attribute :idShort
      attribute :idAttachmentCover
      attribute :manualCoverAttachment
      attribute :labels
      attribute :name
      attribute :pos
      attribute :shortUrl
      attribute :url
      attribute :actions,               Array[Troo::Remote::Comment]

      class << self
        def remote_options
          { mode: :card }
        end

        def by_board_id
          {
            endpoint: :cards_by_board_id,
            query:    { filter: :open }
          }
        end

        def by_list_id
          {
            endpoint: :cards_by_list_id,
            query:    { filter: :open }
          }
        end

        def by_card_id
          {
            endpoint: :card_by_id,
            query:    { actions: :commentCard }
          }
        end
      end

      def associations
        [:actions]
      end

      def local_model
        Troo::Card
      end

      def adapted
        {
          short_id:            idShort,
          name:                name,
          desc:                desc,
          url:                 url,
          position:            pos,
          last_activity_date:  dateLastActivity,
          closed:              closed,
          external_board_id:   idBoard,
          external_list_id:    idList,
          external_id:         id,
          external_member_ids: idMembers
        }
      end
    end
  end
end
