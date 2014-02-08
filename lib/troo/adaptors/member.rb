module Troo
  module Adaptors
    class Member < Resource
      def adapted
        {
          external_member_id: external_member_id,
          username:           username,
          email:              email,
          full_name:          full_name,
          initials:           initials,
          avatar_id:          avatar_id,
          bio:                bio,
          url:                url
        }
      end

      private

      def external_member_id
        resource.id
      end

      def username
        resource.username
      end

      def email
        resource.email
      end

      def full_name
        resource.full_name
      end

      def initials
        resource.initials
      end

      def avatar_id
        resource.avatar_id
      end

      def bio
        resource.bio
      end

      def url
        resource.url
      end
    end
  end
end
