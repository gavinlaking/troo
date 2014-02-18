module Troo
  module Commands
    module Show
      class List < Resource
        private

        def resource
          List.retrieve(id)
        end

        def type
          'list'
        end
      end
    end
  end
end
