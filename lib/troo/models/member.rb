module Troo
  class Member
    include DataMapper::Resource
    include ModelHelpers

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
    has n, :comments, parent_key: [ :external_member_id ],
                      child_key:  [ :external_member_id ]
  end
end

