module Ctrlo
  class Card
    include DataMapper::Resource

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
      def retrieve(id)
        get(id) ||
        all(short_id: id).first ||
        all(external_card_id: id).first ||
        get_remote(id).first
      end

      def retrieve_all
        all
      end

      def persist(card_collection)
        card_collection.map do |c|
          Card.first_or_create({ external_card_id: c.id },
                               { external_board_id:   c.board_id,
                                 external_list_id:    c.list_id,
                                 external_card_id:    c.id,
                                 external_member_ids: c.member_ids,
                                 short_id:            c.short_id,
                                 name:                c.name,
                                 desc:                c.desc,
                                 url:                 c.url,
                                 position:            c.pos,
                                 last_activity_date:  c.last_activity_date,
                                 closed:              c.closed })
        end
      end

      def current
        raise StandardError, "No card set to current." unless all(current: true).any?
        all(current: true)
      end

      private

      def get_remote(external_card_id)
        persist ExternalCard.request(external_card_id, { is_card_id: true })
      end
    end

    def members
      []
    end

    def content
      current = current? ? "* " : ""
      {
        id:       [current, id].join.rjust(6),
        name:     ["(", short_id, ") ", name].join,
        comments: comments.size
      }
    end

    def header
      { id: "", name: list.name, comments: "Comments" }
    end
  end
end

