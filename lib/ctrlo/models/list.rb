module Ctrlo
  class List
    include DataMapper::Resource
    include ModelHelpers

    property :id,                Serial
    property :name,              Text
    property :position,          Integer
    property :current,           Boolean, default: false
    property :closed,            Boolean, default: false
    property :external_board_id, String
    property :external_list_id,  String

    belongs_to :board, :parent_key => [ :external_board_id ],
                       :child_key  => [ :external_board_id ],
                       :required   => true
    has n,     :cards, :parent_key => [ :external_list_id ],
                       :child_key  => [ :external_list_id ],
                       :constraint => :skip

    class << self
      def retrieve(id = nil)
        return all unless id
        get(id)                     ||
        first(external_list_id: id) ||
        get_remote(id)
      end

      def persist(collection)
        collection.map do |l|
          incoming = { external_board_id: l.board_id,
                       external_list_id:  l.id,
                       name:              l.name,
                       position:          l.pos,
                       closed:            l.closed }

          local = first(external_list_id: l.id)
          if local
            local.update(incoming) unless local.external_attributes == incoming
            local
          else
            create(incoming)
          end
        end
      end

      def current
        raise StandardError, "No list set to current." unless all(current: true).any?
        first(current: true)
      end

      private

      def get_remote(external_list_id)
        ExternalList.fetch(external_list_id, { mode: :list }).first
      end
    end
  end
end
