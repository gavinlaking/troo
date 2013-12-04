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
        get(id) || all(external_board_id: id).first || get_remote(id).first
      end

      def retrieve_all
        all
      end

      def persist(board_collection)
        board_collection.map do |b|
          Board.first_or_create({ external_board_id: b.id },
                                { external_board_id: b.id,
                                  name:              b.name,
                                  closed:            b.closed })
        end
      end

      def current
        raise StandardError, "No board set to current." unless all(current: true).any?
        all(current: true)
      end

      private

      def get_remote(external_board_id)
        persist ExternalBoard.request(external_board_id)
      end
    end

    def content
      current = current? ? "* " : ""
      { id: [current, id].join.rjust(6), name: name }
    end

    def header
      { id: "", name: "Name" }
    end
  end
end

