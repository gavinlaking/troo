module Troo
  module Commands
    module Add
      class List < Resource
        def add
          return success if created
          error_trello_error
        end

        private

        def success
          "New list '#{value}' created."
        end

        def error_trello_error
          'List could not be created.'
        end

        def created
          @created ||= CreateList.for(resource, value)
        end

        def resource
          Board.retrieve(id)
        end
      end
    end
  end
end
