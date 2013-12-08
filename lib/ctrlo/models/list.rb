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

    belongs_to :board, parent_key: [ :external_board_id ],
                       child_key:  [ :external_board_id ],
                       required:   true
    has n,     :cards, parent_key: [ :external_list_id ],
                       child_key:  [ :external_list_id ],
                       constraint: :skip

    class << self
      def current
        raise StandardError, "No list set to current." unless all(current: true).any?
        first(current: true)
      end
    end
  end
end
