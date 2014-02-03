module Troo
  module Commands
    module Show
      class Card < Resource
        private

        def resource
          Retrieval::Card.retrieve(id)
        end
      end
    end
  end
end
