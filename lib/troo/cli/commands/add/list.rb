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
          @create ||= Remote::Persistence::List
            .with(resource.external_id, value)
        end

        def resource
          @resource ||= Troo::Board.retrieve(id)
        end
      end
    end
  end
end
