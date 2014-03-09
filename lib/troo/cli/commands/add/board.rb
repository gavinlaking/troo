module Troo
  module Commands
    module Add
      class Board < Resource
        private

        def create
          @create ||= Remote::Persistence::Board.with(value)
        end
      end
    end
  end
end
