module Troo
  module Commands
    module Show
      class List < Resource
        private

        def resource
          List.retrieve(id)
        end
      end
    end
  end
end
