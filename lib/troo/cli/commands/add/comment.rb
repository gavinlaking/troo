module Troo
  module Commands
    module Add
      class Comment < Resource
        private

        def create
          return false if no_resource?
          @create ||= Remote::Persistence::Comment
            .with(resource.external_id, value)
        end
      end
    end
  end
end
