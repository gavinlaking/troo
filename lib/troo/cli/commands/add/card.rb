module Troo
  module Commands
    module Add
      class Card < Resource
        private

        def create
          return false if no_resource?
          @create ||= Remote::Persistence::Card
            .with(resource.external_id, value)
        end
      end
    end
  end
end
