module Ctrlo
  class List
    include DataMapper::Resource

    property :id,                Serial
    property :name,              String
    property :position,          Integer
    property :current,           Boolean, default: false
    property :closed,            Boolean, default: false
    property :external_board_id, String
    property :external_list_id,  String

    belongs_to :board, :parent_key => [ :external_board_id ],
                       :child_key  => [ :external_board_id ],
                       :required   => true
    has n,     :cards, :parent_key => [ :external_list_id ],
                       :child_key  => [ :external_list_id ]

    class << self
      def retrieve(id)
        get(id) || all(external_list_id: id).first || get_remote(id).first
      end

      def retrieve_all
        all
      end

      def persist(list_collection)
        list_collection.map do |l|
          List.first_or_create({ external_list_id: l.id },
                               { external_board_id: l.board_id,
                                 external_list_id:  l.id,
                                 name:              l.name,
                                 position:          l.pos,
                                 closed:            l.closed })
        end
      end

      def current
        raise StandardError, "No list set to current." unless all(current: true).any?
        all(current: true)
      end

      private

      def get_remote(external_list_id)
        persist ExternalList.request(external_list_id, { by_list_id: true })
      end
    end

    def content
      current = current? ? "* " : ""
      { id: [current, id].join.rjust(6), name: name }
    end

    def header
      { id: "", name: board.name }
    end
  end
end
