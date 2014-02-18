module Troo
  module Commands
    module Show
      class List < Resource
        private

        def resource
          Troo::List.retrieve(id)
        end

        def type
          'list'
        end
      end
    end
  end
end
