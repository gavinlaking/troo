module Troo
  module Commands
    module Add
      class Board
        class << self
          def dispatch(value)
            new(value).add
          end
        end

        def initialize(value)
          @value = value
        end

        def add
          return success if created?
          error
        end

        private
        attr_reader :value

        def success
          "New board '#{value}' created."
        end

        def error
          "Board could not be created."
        end

        def created?
          @created ||= CreateBoard.with(value)
        end
      end
    end
  end
end
