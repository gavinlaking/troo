module Troo
  module Remote
    class Comment
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :idMemberCreator
      attribute :data,            CommentData
      attribute :type
      attribute :date
      attribute :memberCreator

      def external_board_id
        data.board.id
      end

      def external_card_id
        data.card.id
      end

      def external_comment_id
        id
      end

      def id_member_creator
        idMemberCreator
      end
      alias_method :member_creator_id,  :id_member_creator
      alias_method :external_member_id, :id_member_creator

      def text
        data.text
      end

      def member_creator
        memberCreator
      end

      def associations
        []
      end

      def local_model
        Troo::Comment
      end

      def adaptor
        Adaptors::Comment
      end
    end
  end
end
