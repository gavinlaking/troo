module Troo
  module Commands
    module Status
      class Board < Resource
        private

        def count
          @count ||= Troo::Board.count
        end

        def resource
          @resource ||= Retrieval::Board.default
        end

        def type
          'board'
        end
      end
    end
  end
end
