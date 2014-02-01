module Troo
  module Commands
    module Status
      class Board
        include CommandHelpers

        class << self
          def dispatch
            new.get_status
          end
        end

        def get_status
          return success if resource
          return error
        end

        private

        def success
          "  Boards: " + plural("board") + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            "  Boards: " + Esc.red + "No default board set." + Esc.reset
          else
            "  Boards: No boards found.\n"
          end
        end

        def resource_title
          resource.decorator.title
        end

        def count
          @count ||= Troo::Board.count
        end

        def resource
          @resource ||= BoardRetrieval.default
        end

        def plural(singular)
          count == 1 ? "#{count} #{singular}" : "#{count} #{singular}s"
        end
      end
    end
  end
end
