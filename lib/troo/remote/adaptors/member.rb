module Troo
  module Remote
    module Adaptors
      class Member < Resource
        def adapted
          {
            external_member_id: resource.id,
            username:           resource.username,
            email:              resource.email,
            full_name:          resource.fullName,
            initials:           resource.initials,
            avatar_id:          resource.avatarHash,
            bio:                resource.bio,
            url:                resource.url
          }
        end
      end
    end
  end
end
