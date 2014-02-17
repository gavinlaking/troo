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

      alias_method :external_board_id, :idBoard
      alias_method :external_list_id,  :id
      alias_method :position,          :pos

      class << self
        def with_collection(resources = [])
          resources.map { |resource| new(resource) }
        end
      end
    end
  end
end
