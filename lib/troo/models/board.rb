module Troo
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

    def self.current
      first(current: true)
    end
  end
end

