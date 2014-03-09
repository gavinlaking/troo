module Troo
  module Commands
    module Add
      class List < Resource
        private

        def create
          return false if no_resource?
          @create ||= Remote::Persistence::List
            .with(resource.external_id, value)
        end
      end
    end
  end
end
