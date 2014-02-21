module Troo
  module Commands
    module Add
      class List < Resource
        def add
          return success if create
          error
        end

        private

        def success
          "New list '#{value}' created."
        end

        def error
          'List could not be created.'
        end

        def create
          @create ||= CreateList.with(resource, value)
        end

        def resource
          @resource ||= Troo::Board.retrieve(id)
        end
      end
    end
  end
end
