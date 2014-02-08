module Troo
  module Commands
    module Default
      class Board < Resource
        private

        def success
          "'#{resource_name}' set as default board."
        end

        def error
          'Board cannot be found.'
        end

        def resource_name
          resource.decorator.name
        end

        def resource
          Retrieval::Board.retrieve(id)
        end
      end
    end
  end
end
