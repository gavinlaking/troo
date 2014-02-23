module Troo
  module Commands
    module Refresh
      class Board < Resource
        private

        def type
          'board'
        end

        def resource
          return [] unless local
          @resource ||= Troo::Board
            .fetch(external_board_id, mode: :board)
        end

        def external_board_id
          local.external_board_id
        end

        def local
          @local ||= Troo::Board.retrieve(id)
        end
      end
    end
  end
end
