module Ctrlo
  class Member
    include DataMapper::Resource

    property :id,                 Serial
    property :username,           String
    property :email,              String
    property :full_name,          String
    property :initials,           String
    property :avatar_id,          String
    property :bio,                Text
    property :url,                String
    property :external_member_id, String

    # has n, :cards
    has n, :comments, :parent_key => [ :external_member_id ],
                      :child_key  => [ :external_member_id ]

    class << self
      def retrieve(id)
        get(id) || all(external_member_id: id).first || get_remote(id).first
      end

      def retrieve_all
        all
      end

      def persist(member_collection)
        member_collection.map do |m|
          Member.first_or_create({ external_member_id: m.id },
                                 { external_member_id: m.id,
                                   username:           m.username,
                                   email:              m.email,
                                   full_name:          m.full_name,
                                   initials:           m.initials,
                                   avatar_id:          m.avatar_id,
                                   bio:                m.bio,
                                   url:                m.url })
        end
      end

      private

      def get_remote(external_member_id)
        persist ExternalMember.request(external_member_id, { is_member_id: true })
      end
    end
  end
end

