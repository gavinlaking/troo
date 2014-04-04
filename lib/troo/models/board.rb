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
      # @return []
      def remote
        Remote::Board
      end

      # @return []
      def type
        :board
      end
    end

    # @return []
    def lists
      Troo::List.find(external_board_id: external_id)
    end

    # @return []
    def cards
      Troo::Card.find(external_board_id: external_id)
    end

    # @param  []
    # @return []
    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    # @param  []
    # @return []
    def presenter(options = {})
      Presenters::Board.new(self, options)
    end

    # @return []
    def type
      self.class.type
    end
  end
end
