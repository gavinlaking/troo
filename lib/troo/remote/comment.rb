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

        def all
          {}
        end

        def by_board_id
          {
            endpoint: :comments_by_board_id,
            query:    { filter: :commentCard }
          }
        end

        def by_list_id
          {}
        end

        def by_card_id
          {
            endpoint: :comments_by_card_id,
            query:    { filter: :commentCard }
          }
        end

        def by_member_id
          {}
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

      def adaptor
        Adaptors::Comment
      end
    end
  end
end
