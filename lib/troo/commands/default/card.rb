module Troo
  module Commands
    module Default
      class Card < Resource
        private

        def success
          "'#{resource_name}' set as default card."
        end

        def error
          'Card cannot be found.'
        end

        def resource_name
          resource.decorator.name
        end

        def resource
          Retrieval::Card.retrieve(id)
        end
      end
    end
  end
end
