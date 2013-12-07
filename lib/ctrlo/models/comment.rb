module Ctrlo
  class Comment
    include DataMapper::Resource
    include ModelHelpers

    property :id,                  Serial
    property :text,                Text
    property :date,                DateTime
    property :external_comment_id, String
    property :external_board_id,   String
    property :external_card_id,    String
    property :external_member_id,  String

    belongs_to :board,  :parent_key => [ :external_board_id ],
                        :child_key  => [ :external_board_id ],
                        :required   => true
    belongs_to :card,   :parent_key => [ :external_card_id ],
                        :child_key  => [ :external_card_id ],
                        :required   => true
    belongs_to :member, :parent_key => [ :external_member_id ],
                        :child_key  => [ :external_member_id ],
                        :required   => true

    class << self
      def retrieve(id = nil)
        return all unless id
        get(id) ||
        first(external_comment_id: id)
      end

      def persist(collection)
        collection.map do |c|
          incoming = { external_comment_id: c.id,
                       external_board_id:   c.data["board"]["id"],
                       external_card_id:    c.data["card"]["id"],
                       external_member_id:  c.member_creator_id,
                       date:                c.date,
                       text:                c.data["text"] }

          local = first(external_comment_id: c.id)
          if local
            local.update(incoming) unless local.external_attributes == incoming
            local
          else
            create(incoming)
          end
        end
      end
    end
  end
end

