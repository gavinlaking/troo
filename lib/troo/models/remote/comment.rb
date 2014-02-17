module Troo
  module Remote
    class Comment
      include Virtus.model(finalize: false)

      attribute :id
      attribute :idMemberCreator
      attribute :data, CommentData
      attribute :type
      attribute :date
      attribute :memberCreator

      def id_member_creator
        idMemberCreator
      end
      alias_method :member_creator_id, :id_member_creator

      def member_creator
        memberCreator
      end
    end

    Virtus.finalize
  end
end
