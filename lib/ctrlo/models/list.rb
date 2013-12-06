module Ctrlo
  class List
    include DataMapper::Resource

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
      def retrieve(id)
        get(id)                     ||
        first(external_list_id: id) ||
        get_remote(id)
      end

      def retrieve_all
        all
      end

      def persist(list_collection)
        list_collection.map do |l|
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
        ExternalList.refresh(external_list_id, { mode: :list }).first
      end
    end

    def content
      current = current? ? "* " : ""
      { id: [current, id].join.rjust(6), name: name }
    end

    def header
      { id: "", name: board.name }
    end

    def internal_attributes
      self.attributes.keep_if   { |k, _| k == :id || k == :current }
    end

    def external_attributes
      self.attributes.delete_if { |k, _| k == :id || k == :current }
    end
  end
end
