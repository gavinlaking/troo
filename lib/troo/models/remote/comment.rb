module Troo
  module Remote
    class Comment < Resource
      def id
        params.fetch('id')
      end

      def member_creator_id
        params.fetch('idMemberCreator')
      end

      def data
        params.fetch('data')
      end

      def date
        params.fetch('date')
      end
    end
  end
end
