module Troo
  module Commands
    module Status
      class List < Resource
        private

        def count
          @count ||= Troo::List.count
        end

        def resource
          @resource ||= Retrieval::List.default
        end

        def type
          'list'
        end
      end
    end
  end
end
