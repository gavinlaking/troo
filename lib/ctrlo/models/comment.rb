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

    belongs_to :board,  parent_key: [ :external_board_id ],
                        child_key:  [ :external_board_id ],
                        required:   true
    belongs_to :card,   parent_key: [ :external_card_id ],
                        child_key:  [ :external_card_id ],
                        required:   true
    belongs_to :member, parent_key: [ :external_member_id ],
                        child_key:  [ :external_member_id ],
                        required:   true
  end
end

