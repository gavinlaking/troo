module Troo
  module Commands
    module Add
      class List < Resource
        def add
          return success if created
          error
        end

        private

        def success
          "New list '#{value}' created."
        end

        def error
          'List could not be created.'
        end

        def created
          @created ||= CreateList.with(resource, value)
        end

        def resource
          Board.retrieve(id)
        end
      end
    end
  end
end
