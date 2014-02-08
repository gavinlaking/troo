module Troo
  module Commands
    module Add
      class Board < Resource
        def add
          return success if created?
          error
        end

        private

        def success
          "New board '#{value}' created."
        end

        def error
          'Board could not be created.'
        end

        def created?
          @created ||= CreateBoard.with(value)
        end
      end
    end
  end
end
