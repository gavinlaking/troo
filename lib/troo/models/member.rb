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
    attribute :short_id

    index :external_member_id
    index :short_id

    alias_method :external_id, :external_member_id

    class << self
      def by_external_id(id)
        first(external_member_id: id)
      end

      def remote
        Remote::Member
      end

      def type
        :member
      end
    end

    def decorator(options = {})
      Decorators::Member.new(self, options)
    end

    def presenter(options = {})
      Presenters::Member.new(self.decorator, options)
    end

    def default?
      false
    end

    def type
      self.class.type
    end
  end
end
