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
        get(id)                       ||
        first(external_member_id: id) ||
        get_remote(id)
      end

      def retrieve_all
        all
      end

      def persist(member_collection)
        member_collection.map do |m|
          incoming = { external_member_id: m.id,
                       username:           m.username,
                       email:              m.email,
                       full_name:          m.full_name,
                       initials:           m.initials,
                       avatar_id:          m.avatar_id,
                       bio:                m.bio,
                       url:                m.url }

          local = first(external_member_id: m.id)
          if local
            local.update(incoming) unless local.external_attributes == incoming
            local
          else
            create(incoming)
          end
        end
      end

      private

      def get_remote(external_member_id)
        ExternalMember.fetch(external_member_id, { mode: :member }).first
      end
    end

    def internal_attributes
      self.attributes.keep_if   { |k, _| k == :id }
    end

    def external_attributes
      self.attributes.delete_if { |k, _| k == :id }
    end
  end
end

