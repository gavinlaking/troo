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
      # @return []
      def remote
        Remote::Member
      end

      # @return []
      def type
        :member
      end
    end

    # @param  []
    # @return []
    def decorator(options = {})
      Decorators::Member.new(self, options)
    end

    # @param  []
    # @return []
    def presenter(options = {})
      Presenters::Member.new(decorator, options)
    end

    # @return []
    def default?
      false
    end

    # @return []
    def type
      self.class.type
    end
  end
end
