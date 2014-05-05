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
    attribute :external_id
    attribute :short_id

    index :external_id
    index :short_id

    class << self
      def remote
        Remote::Member
      end

      def type
        :member
      end
    end

    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end
    def presenter(options = {})
      Presenters::Member.new(decorator, options)
    end

    def default?
      false
    end

    def type
      self.class.type
    end
  end
end
