module Troo
  module Remote
    class List
      include Virtus.model

      attribute :id
      attribute :name
      attribute :closed
      attribute :idBoard
      attribute :pos

      alias_method :id_board, :idBoard
    end
  end
end
