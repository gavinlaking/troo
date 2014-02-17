module Troo
  module Commands
    module Status
      class Board < Resource
        private

        def success
          '  Boards: ' + plural('board') + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            '  Boards: ' + no_default_error + " (#{count})"
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

        def no_default_error
          Esc.red + 'No default board set.' + Esc.reset
        end
      end
    end
  end
end
