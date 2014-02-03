module Troo
  module Commands
    module Add
      class List < Resource
        include CommandHelpers

        def add
          if created
            success
          elsif created == false
            error_trello_error
          elsif no_default?
            error_no_default
          else
            error_not_found
          end
        end

        private

        def success
          "New list '#{value}' created."
        end

        def error_trello_error
          "List could not be created."
        end

        def created
          @created ||= CreateList.for(resource, value)
        end

        def resource
          Retrieval::Board.retrieve(id)
        end
      end
    end
  end
end
