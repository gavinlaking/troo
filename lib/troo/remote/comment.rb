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

      class << self
        def remote_options
          { mode: :card }
        end

        def by_board_id
          {
            endpoint: :comments_by_board_id,
            query:    { filter: :commentCard }
          }
        end

        def by_card_id
          {
            endpoint: :comments_by_card_id,
            query:    { filter: :commentCard }
          }
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

      def text
        data.text
      end

      def associations
        [:memberCreator]
      end

      def local_model
        Troo::Comment
      end

      def adapted
        {
          external_comment_id: id,
          external_board_id:   data.board.id,
          external_card_id:    data.card.id,
          external_member_id:  idMemberCreator,
          date:                date,
          text:                text
        }
      end
    end
  end
end
