module Troo
  class Card < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :short_id
    attribute :name
    attribute :desc
    attribute :url
    attribute :external_member_ids, Type::Array
    attribute :position
    attribute :last_activity_date
    attribute :default, Type::Boolean
    attribute :closed, Type::Boolean
    attribute :external_board_id
    attribute :external_list_id
    attribute :external_card_id

    index :short_id
    index :default
    index :external_board_id
    index :external_list_id
    index :external_card_id

    alias_method :default?, :default

    class << self
      def by_external_id(id)
        first(external_card_id: id)
      end

      def fetch(id, options = { mode: :card })
        Remote::Retrieval::Card.fetch(id, options)
      end

      def retrieve(id = nil, options = {})
        Retrieval::Card.retrieve(id, options = {})
      end

      def type
        'card'
      end
    end

    def external_member_ids
      if @attributes[:external_member_ids].nil?
        []
      elsif @attributes[:external_member_ids].is_a?(Array)
        @attributes[:external_member_ids]
      else
        JSON(@attributes[:external_member_ids])
      end
    end

    def board
      @board ||= Troo::Board.retrieve(external_board_id)
    end

    def list
      @list ||= Troo::List.retrieve(external_list_id)
    end

    def comments
      Troo::Comment.find(external_card_id: external_card_id)
    end

    def recent_comments
      comments.sort(by: :date, limit: [0, 3])
    end

    def members
      return [] if external_member_ids.empty?
      @members ||= external_member_ids.map do |member_id|
        Troo::Member.retrieve(member_id)
      end.compact
    end

    def decorator(options = {})
      Decorators::Card.new(self, options)
    end

    def presenter(options = {})
      Presenters::Card.new(self, options)
    end

    def comment_presenter(options = {})
      Presenters::Comment.new(self, options)
    end

    def set_default!
      Behaviours::SetDefault.for(self)
    end
  end
end
