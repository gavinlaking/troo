module Troo
  class Board < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :name
    attribute :description
    attribute :default, Type::Boolean
    attribute :closed, Type::Boolean
    attribute :external_board_id

    index :default
    index :external_board_id

    alias_method :default?,    :default
    alias_method :external_id, :external_board_id

    class << self
      def by_external_id(id)
        first(external_board_id: id)
      end

      def fetch(id, options = { mode: :board })
        Remote::Retrieval::Board.fetch(id, options)
      end

      def retrieve(id = nil, options = {})
        Troo::Retrieval::Board.retrieve(id, options = {})
      end

      def type
        'board'
      end
    end

    def lists
      Troo::List.find(external_board_id: external_board_id)
    end

    def cards
      Troo::Card.find(external_board_id: external_board_id)
    end

    def decorator(options = {})
      Decorators::Board.new(self, options)
    end

    def presenter(options = {})
      Presenters::Board.new(self, options)
    end

    def set_default!
      Behaviours::SetDefault.for(self)
    end
  end
end
