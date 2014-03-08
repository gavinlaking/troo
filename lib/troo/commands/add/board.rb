module Troo
  module Commands
    module Add
      class Board < Resource
        def add
          return success if create
          error
        end

        private

        def success
          "New board '#{value}' created.\n" \
          "Run `troo refresh board #{@create.id}` to retrieve lists."
        end

        def error
          'Board could not be created.'
        end

        def create
          @create ||= Remote::Persistence::Board.with(value)
        end
      end
    end
  end
end
