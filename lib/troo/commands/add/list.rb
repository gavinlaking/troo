module Troo
  module Commands
    module Add
      class List < Resource
        def add
          if created
            success
          else
            error_trello_error
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
