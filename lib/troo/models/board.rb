module Troo
  class Board < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :name
    attribute :description
    attribute :default, Type::Boolean
    attribute :closed, Type::Boolean
    attribute :external_id
    attribute :short_id

    index :default
    index :external_id
    index :short_id

    alias_method :default?,    :default

    class << self
      def remote
        Remote::Board
      end

      def type
        :board
      end
    end

    def lists
      Troo::List.find(external_board_id: external_id)
    end

    def cards
      Troo::Card.find(external_board_id: external_id)
    end

    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    def presenter(options = {})
      Presenters::Board.new(self, options)
    end

    def type
      self.class.type
    end
  end
end
