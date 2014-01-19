module Troo
  class Member < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :username
    attribute :email
    attribute :full_name
    attribute :initials
    attribute :avatar_id
    attribute :bio
    attribute :url
    attribute :external_member_id

    index :external_member_id

    def decorator(options = {})
      MemberDecorator.new(self, options)
    end

    def presenter
      MemberPresenter.new(self)
    end
  end
end

