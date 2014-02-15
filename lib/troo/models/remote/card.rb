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
    end
  end
end
