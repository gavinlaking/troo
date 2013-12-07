module Ctrlo
  class Card
    include DataMapper::Resource
    include ModelHelpers

    property :id,                  Serial
    property :short_id,            Integer
    property :name,                Text
    property :desc,                Text
    #property :due,
    property :url,                 Text
    property :external_member_ids, CommaSeparatedList
    property :position,            Integer
    property :last_activity_date,  DateTime
    property :current,             Boolean, default: false
    property :closed,              Boolean, default: false
    property :external_board_id,   String
    property :external_list_id,    String
    property :external_card_id,    String

    belongs_to :board,    :parent_key => [ :external_board_id ],
                          :child_key  => [ :external_board_id ],
                          :required   => true
    belongs_to :list,     :parent_key => [ :external_list_id ],
                          :child_key  => [ :external_list_id ],
                          :required   => true
    has n,     :comments, :parent_key => [ :external_card_id ],
                          :child_key  => [ :external_card_id ],
                          :constraint => :skip

    class << self
      def retrieve(id = nil)
        return all unless id
        get(id)                     ||
        first(short_id: id)         ||
        first(external_card_id: id) ||
        get_remote(id)
      end

      def persist(collection)
        collection.map do |c|
          incoming = { external_board_id:   c.board_id,
                       external_list_id:    c.list_id,
                       external_card_id:    c.id,
                       external_member_ids: c.member_ids,
                       short_id:            c.short_id,
                       name:                c.name,
                       desc:                c.desc,
                       url:                 c.url,
                       position:            c.pos,
                       last_activity_date:  c.last_activity_date,
                       closed:              c.closed }

          local = first(external_card_id: c.id)
          if local
            local.update(incoming) unless local.external_attributes == incoming
            local
          else
            create(incoming)
          end
        end
      end

      def current
        raise StandardError, "No card set to current." unless all(current: true).any?
        first(current: true)
      end

      private

      def get_remote(external_card_id)
        ExternalCard.fetch(external_card_id, { mode: :card }).first
      end
    end

    def members
      []
    end
  end
end

