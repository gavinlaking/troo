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

      # @return [Symbol]
      def type
        :member
      end
    end

    # @param  [Hash]
    # @return []
    def decorator(options = {})
      Decorators::Member.new(self, options)
    end

    # @param  [Hash]
    # @return []
    def presenter(options = {})
      Presenters::Member.new(decorator, options)
    end

    # @return [FalseClass]
    def default?
      false
    end

    # @return [Symbol]
    def type
      self.class.type
    end
  end
end
