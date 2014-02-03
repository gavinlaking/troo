module Troo
  module Commands
    module Show
      class List < Resource
        private

        def resource
          Retrieval::List.retrieve(id)
        end
      end
    end
  end
end
