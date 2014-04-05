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
    attribute :external_id

    index :short_id
    index :default
    index :external_board_id
    index :external_list_id
    index :external_id

    alias_method :default?,    :default
    alias_method :description, :desc

    class << self
      # @return []
      def remote
        Remote::Card
      end

      # @return [Symbol]
      def type
        :card
      end
    end

    # @return []
    def external_member_ids
      if @attributes[:external_member_ids].nil?
        []
      elsif @attributes[:external_member_ids].is_a?(Array)
        @attributes[:external_member_ids]
      else
        JSON(@attributes[:external_member_ids])
      end
    end

    # @return []
    def board
      @board ||= Troo::Board.retrieve(external_board_id)
    end

    # @return []
    def list
      @list ||= Troo::List.retrieve(external_list_id)
    end

    # @return []
    def comments
      Troo::Comment.find(external_card_id: external_id)
    end

    # @return []
    def recent_comments
      comments.sort(by: :date, limit: [0, 3])
    end

    # @return []
    def members
      return [] if external_member_ids.empty?
      @members ||= external_member_ids.map do |member_id|
        Troo::Member.retrieve(member_id)
      end.compact
    end

    # @param  [Hash]
    # @return []
    def decorator(options = {})
      Decorators::Resource.new(self, options)
    end

    # @param  [Hash]
    # @return []
    def presenter(options = {})
      Presenters::Card.new(self, options)
    end

    # @param  [Hash]
    # @return []
    def comment_presenter(options = {})
      Presenters::Comment.new(self, options)
    end

    # @return [Symbol]
    def type
      self.class.type
    end
  end
end
