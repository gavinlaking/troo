module Troo
  class List < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :name
    attribute :position,         Type::Integer
    attribute :default,          Type::Boolean
    attribute :closed,           Type::Boolean
    attribute :external_board_id
    attribute :external_list_id
    attribute :short_id

    index :default
    index :external_board_id
    index :external_list_id
    index :short_id

    alias_method :default?,    :default
    alias_method :external_id, :external_list_id

    class << self
      def by_external_id(id)
        first(external_list_id: id)
      end

      def fetch(id, options = { mode: :list })
        Remote::Retrieval::List.fetch(id, options)
      end

      def type
        'list'
      end
    end

    def board
      Troo::Board.retrieve(external_board_id)
    end

    def cards
      Troo::Card.find(external_list_id: external_list_id)
    end

    def decorator(options = {})
      Decorators::List.new(self, options)
    end

    def presenter(options = {})
      Presenters::List.new(self, options)
    end
  end
end
