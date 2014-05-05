module Troo
  class List < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :name
    attribute :position,         Type::Integer
    attribute :default,          Type::Boolean
    attribute :closed,           Type::Boolean
    attribute :external_board_id
    attribute :external_id
    attribute :short_id

    index :default
    index :external_board_id
    index :external_id
    index :short_id

    alias_method :default?,    :default

    class << self
      def remote
        Remote::List
      end

      def type
        :list
      end
    end

    def board
      Troo::Board.retrieve(external_board_id)
    end

    def cards
      Troo::Card.find(external_list_id: external_id)
    end

    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    def presenter(options = {})
      Presenters::List.new(self, options)
    end

    def type
      self.class.type
    end
  end
end
