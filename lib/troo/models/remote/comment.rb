module Troo
  module Remote
    # class Comment < Resource
    #   def id
    #     params.fetch('id')
    #   end

    #   def member_creator_id
    #     params.fetch('idMemberCreator')
    #   end

    #   def data
    #     params.fetch('data')
    #   end

    #   def date
    #     params.fetch('date')
    #   end
    # end

    class Comment
      include Virtus.model(:finalize => false)

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
