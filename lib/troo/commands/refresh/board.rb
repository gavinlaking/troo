module Troo
  module Commands
    module Refresh
      class Board
        include CommandHelpers

        class << self
          def dispatch(id = nil)
            new(id).refresh
          end
        end

        def initialize(id = nil)
          @id = id
        end

        def refresh
          if resource.one?
            success
          elsif resource.count > 1
            many_success
          else
            error
          end
        end

        private
        attr_reader :type, :id

        def success
          "'#{resource_name}' refreshed."
        end

        def many_success
          "Multiple boards refreshed."
        end

        def error
          return "Default board cannot be found." unless id
          @type = :board
          "Board cannot be found. " + error_no_default
        end

        def resource_name
          resource.first.decorator.name
        end

        def resource
          return [] unless local
          @resource ||= External::Board.fetch(local.external_board_id)
        end

        def local
          @local ||= Retrieval::Board.retrieve(id)
        end
      end
    end
  end
end
