module Troo
  module Remote
    class List
      include Virtus.model
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :name
      attribute :closed,  Boolean
      attribute :idBoard
      attribute :pos,     Integer

      alias_method :id_board,          :idBoard

      alias_method :external_board_id, :idBoard
      alias_method :external_list_id,  :id
      alias_method :position,          :pos
    end
  end
end
