module Troo
  module Commands
    module Show
      class Board < Resource
        private

        def resource
          Board.retrieve(id)
        end

        def type
          'board'
        end
      end
    end
  end
end
