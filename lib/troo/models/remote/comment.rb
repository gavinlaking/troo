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

      class << self
        def with_collection(resources = [])
          resources.map { |resource| new(resource) }
        end
      end

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
    end

    Virtus.finalize
  end
end
