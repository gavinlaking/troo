module Troo
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

    belongs_to :board,    parent_key: [ :external_board_id ],
                          child_key:  [ :external_board_id ],
                          required:   true
    belongs_to :list,     parent_key: [ :external_list_id ],
                          child_key:  [ :external_list_id ],
                          required:   true
    has n,     :comments, parent_key: [ :external_card_id ],
                          child_key:  [ :external_card_id ],
                          constraint: :skip

    def members
      []
    end
  end
end

