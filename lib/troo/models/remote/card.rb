module Troo
  module Remote
    class Card
      include Virtus.model

      attribute :id
      attribute :badges
      attribute :checkItemStates
      attribute :closed
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

      alias_method :check_item_states,       :checkItemStates
      alias_method :date_last_activity,      :dateLastActivity
      alias_method :desc_data,               :descData
      alias_method :id_board,                :idBoard
      alias_method :id_checklists,           :idChecklists
      alias_method :id_list,                 :idList
      alias_method :id_members,              :idMembers
      alias_method :id_short,                :idShort
      alias_method :id_attachment_cover,     :idAttachmentCover
      alias_method :manual_cover_attachment, :manualCoverAttachment
      alias_method :short_url,               :shortUrl

      alias_method :external_board_id,       :idBoard
      alias_method :external_list_id,        :idList
      alias_method :external_card_id,        :id
      alias_method :external_member_ids,     :idMembers
      alias_method :short_id,                :idShort
      alias_method :position,                :pos
      alias_method :last_activity_date,      :dateLastActivity

      class << self
        def with_collection(resources = [])
          resources.map { |resource| new(resource) }
        end
      end
    end
  end
end
