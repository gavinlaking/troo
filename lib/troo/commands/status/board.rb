module Troo
  module Commands
    module Status
      class Board < Resource
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

        def count
          @count ||= Troo::Board.count
        end

        def resource
          @resource ||= Retrieval::Board.default
        end
      end
    end
  end
end
