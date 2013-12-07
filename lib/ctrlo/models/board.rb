module Ctrlo
  class Board
    include DataMapper::Resource
    include ModelHelpers

    property :id,                Serial
    property :name,              Text
    property :current,           Boolean, default: false
    property :closed,            Boolean, default: false
    property :external_board_id, String

    has n, :lists, parent_key: [ :external_board_id ],
                   child_key:  [ :external_board_id ],
                   constraint: :skip
    has n, :cards, parent_key: [ :external_board_id ],
                   child_key:  [ :external_board_id ],
                   constraint: :skip
    #has n, :members

    class << self
      def retrieve(id = nil)
        return all unless id
        get(id)                      ||
        first(external_board_id: id) ||
        get_remote(id)
      end

      def persist(collection)
        collection.map do |b|
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
        ExternalBoard.fetch(external_board_id, { mode: :board }).first
      end
    end
  end
end

