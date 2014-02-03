module Troo
  module Commands
    module Show
      class Board < Resource
        private

        def resource
          Retrieval::Board.retrieve(id)
        end
      end
    end
  end
end
