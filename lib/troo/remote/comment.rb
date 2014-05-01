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
        # @return [Hash]
        def remote_options
          { mode: :card }
        end

        # @return [Hash]
        def by_board_id
          {
            endpoint: :comments_by_board_id,
            query:    { filter: :commentCard }
          }
        end

        # @return [Hash]
        def by_card_id
          {
            endpoint: :comments_by_card_id,
            query:    { filter: :commentCard }
          }
        end
      end

      # @return [String]
      def external_board_id
        data.board.id
      end

      # @return [String]
      def external_card_id
        data.card.id
      end

      # @return [String]
      def external_comment_id
        id
      end

      # @return [String]
      def text
        data.text
      end

      # @return [Array]
      def associations
        [:memberCreator]
      end

      # @return [Class]
      def local_model
        Troo::Comment
      end

      # @return [Hash]
      def adapted
        {
          external_id:        id,
          external_board_id:  data.board.id,
          external_card_id:   data.card.id,
          external_member_id: idMemberCreator,
          date:               date,
          text:               text
        }
      end
    end
  end
end
