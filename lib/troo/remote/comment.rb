module Troo
  module Remote
    class Comment
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :idMemberCreator
      attribute :data,            Troo::Remote::CommentData
      attribute :type
      attribute :date
      attribute :memberCreator,   Troo::Remote::Member

      def external_board_id
        data.board.id
      end

      def external_card_id
        data.card.id
      end

      def external_comment_id
        id
      end

      def text
        data.text
      end

      def associations
        [:memberCreator]
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
