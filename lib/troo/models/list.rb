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
      # @return [Remote::List]
      def remote
        Remote::List
      end

      # @return [Symbol]
      def type
        :list
      end
    end

    # @return [Troo::Board]
    def board
      Troo::Board.retrieve(external_board_id)
    end

    # @return [Ohm::Set]
    def cards
      Troo::Card.find(external_list_id: external_id)
    end

    # @param  options [Hash]
    # @return [Decorators::Resource]
    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    # @param  options [Hash]
    # @return [Troo::Presenters::List]
    def presenter(options = {})
      Presenters::List.new(self, options)
    end

    # @return [Symbol]
    def type
      self.class.type
    end
  end
end
