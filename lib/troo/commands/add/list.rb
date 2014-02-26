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
          return false if no_resource?
          @create ||= CreateList.with(external_board_id, value)
        end

        def external_board_id
          resource.external_board_id
        end

        def resource
          @resource ||= Troo::Board.retrieve(id)
        end
      end
    end
  end
end
