module Troo
  module Persistence
    class Comment < Resource
      private

      def created
        Troo::Comment.create(remote_data)
      end

      def local
        @local ||= Troo::Comment.first(external_comment_id: resource.id)
      end

      def remote_data
        @remote ||= Adaptors::Comment.adapt(resource)
      end
    end
  end
end
