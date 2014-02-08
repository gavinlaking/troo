module Troo
  module Commands
    module Status
      class List < Resource
        private

        def success
          '  Lists:  ' + plural('list') + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            '  Lists:  ' + Esc.red + 'No default list set.' + Esc.reset
          else
            "  Lists:  No lists found.\n"
          end
        end

        def count
          @count ||= Troo::List.count
        end

        def resource
          @resource ||= Retrieval::List.default
        end
      end
    end
  end
end
