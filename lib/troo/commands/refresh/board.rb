module Troo
  module Commands
    module Refresh
      class Board < Resource
        private

        def many_success
          'Multiple boards refreshed.'
        end

        def error
          return 'Default board cannot be found.' unless id
          @type = :board
          'Board cannot be found. ' + error_no_default
        end

        def resource
          return [] unless local
          @resource ||= Board.remote(local.external_board_id, { mode: :board })
        end

        def local
          @local ||= Board.retrieve(id)
        end
      end
    end
  end
end
