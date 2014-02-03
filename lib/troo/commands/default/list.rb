module Troo
  module Commands
    module Default
      class List < Resource
        private

        def success
          "'#{resource_name}' set as default list."
        end

        def error
          "List cannot be found."
        end

        def resource_name
          resource.decorator.name
        end

        def resource
          Retrieval::List.retrieve(id)
        end
      end
    end
  end
end
