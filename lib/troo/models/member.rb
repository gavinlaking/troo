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

    class << self
      def by_external_id(id)
        first(external_member_id: id)
      end

      def fetch(id, options = { mode: :member })
        Remote::Retrieval::Member.fetch(id, options)
      end

      def retrieve(id = nil, options = {})
        Retrieval::Member.retrieve(id, options = {})
      end
    end

    def decorator(options = {})
      Decorators::Member.new(self, options)
    end

    def presenter(options = {})
      Presenters::Member.new(self, options)
    end

    def default?
      false
    end
  end
end
