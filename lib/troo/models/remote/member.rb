module Troo
  module Remote
    class Member
      include Virtus.model(finalize: false)
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

      def associations
        []
      end

      def local_model
        Troo::Member
      end

      def adaptor
        Adaptors::Member
      end
    end
  end
end
