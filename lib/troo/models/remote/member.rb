module Troo
  module Remote
    class Member
      include Virtus.model
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :avatarHash
      attribute :bio
      attribute :bioData
      attribute :confirmed
      attribute :fullName
      attribute :idPremOrgsAdmin
      attribute :initials
      attribute :memberType
      attribute :products
      attribute :status
      attribute :url
      attribute :username
      attribute :avatarSource
      attribute :email
      attribute :gravatarHash
      attribute :idBoards
      attribute :idBoardsInvited
      attribute :idBoardsPinned
      attribute :idOrganizations
      attribute :idOrganizationsInvited
      attribute :loginTypes
      attribute :newEmail
      attribute :oneTimeMessagesDismissed
      attribute :prefs
      attribute :trophies
      attribute :uploadedAvatarHash
      attribute :premiumFeatures

      alias_method :avatar_hash,                 :avatarHash
      alias_method :bio_data,                    :bioData
      alias_method :full_name,                   :fullName
      alias_method :id_prem_orgs_admin,          :idPremOrgsAdmin
      alias_method :member_type,                 :memberType
      alias_method :avatar_source,               :avatarSource
      alias_method :gravatar_hash,               :gravatarHash
      alias_method :id_boards,                   :idBoards
      alias_method :id_boards_invited,           :idBoardsInvited
      alias_method :id_boards_pinned,            :idBoardsPinned
      alias_method :id_organizations,            :idOrganizations
      alias_method :id_organizations_invited,    :idOrganizationsInvited
      alias_method :login_types,                 :loginTypes
      alias_method :new_email,                   :newEmail
      alias_method :one_time_messages_dismissed, :oneTimeMessagesDismissed
      alias_method :uploaded_avatar_hash,        :uploadedAvatarHash
      alias_method :premium_features,            :premiumFeatures

      alias_method :external_member_id,          :id
      alias_method :avatar_id,                   :avatarHash
    end
  end
end
