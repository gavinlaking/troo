module Troo
  module Adaptors
    class Member < Resource
      def adapted
        {
          external_member_id: resource.external_member_id,
          username:           resource.username,
          email:              resource.email,
          full_name:          resource.full_name,
          initials:           resource.initials,
          avatar_id:          resource.avatar_id,
          bio:                resource.bio,
          url:                resource.url
        }
      end
    end
  end
end
