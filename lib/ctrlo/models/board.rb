module Ctrlo
  class Board
    include DataMapper::Resource

    property :id,                Serial
    property :name,              Text
    property :current,           Boolean, default: false
    property :closed,            Boolean, default: false
    property :external_board_id, String

    has n, :lists, :parent_key => [ :external_board_id ],
                   :child_key  => [ :external_board_id ],
                   :constraint => :skip
    has n, :cards, :parent_key => [ :external_board_id ],
                   :child_key  => [ :external_board_id ],
                   :constraint => :skip
    #has n, :members

    class << self
      def retrieve(id)
        get(id)                      ||
        first(external_board_id: id) ||
        get_remote(id)
      end

      def retrieve_all
        all
      end

      def persist(board_collection)
        board_collection.map do |b|
          incoming = { external_board_id: b.id,
                       name:              b.name,
                       closed:            b.closed }

          local = first(external_board_id: b.id)
          if local
            local.update(incoming) unless local.external_attributes == incoming
            local
          else
            create(incoming)
          end
        end
      end

      def current
        raise StandardError, "No board set to current." unless all(current: true).any?
        first(current: true)
      end

      private

      def get_remote(external_board_id)
        persist(ExternalBoard.fetch_by_external_id(external_board_id)).first
      end
    end

    def internal_attributes
      self.attributes.keep_if   { |k, _| k == :id || k == :current }
    end

    def external_attributes
      self.attributes.delete_if { |k, _| k == :id || k == :current }
    end
  end
end

