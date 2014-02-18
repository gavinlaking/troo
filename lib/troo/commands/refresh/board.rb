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
          @resource ||= Troo::Board.remote(local.external_board_id, { mode: :board })
        end

        def local
          @local ||= Troo::Board.retrieve(id)
        end
      end
    end
  end
end
