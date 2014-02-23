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

      def associations
        []
      end

      def local_model
        Troo::Card
      end

      def adaptor
        Adaptors::Card
      end
    end
  end
end
