module Troo
  module Commands
    module Status
      class Board
        include CommandHelpers

        class << self
          def dispatch(type, id = nil)
            new(type, id).get_status
          end
        end

        def initialize(type, id = nil)
          @type, @id = type, id
        end

        def get_status
          return success if resource
          return error
        end

        private
        attr_reader :type, :id

        def success
          "  Boards:".ljust(10)           +
          plural(count, "board") +
          " found.\n"                     +
          "          #{resource_title}"
        end

        def error
          if count > 0
            Esc.red + "  Boards:  No default board set." + Esc.reset
          else
            "   Boards: " + " No boards found.\n"
          end
        end

        def resource_title
          resource.decorator.title
        end

        def count
          @count = Troo::Board.count
        end

        def resource
          @resource ||= BoardRetrieval.retrieve(id)
        end

        def plural(size, singular)
          case size
          when 0 then "No #{singular}s"
          when 1 then "#{size} #{singular}"
          else "#{size} #{singular}s"
          end
        end
      end
    end
  end
end
