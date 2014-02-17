module Troo
  module Commands
    module Show
      class Card < Resource
        private

        def resource
          Card.retrieve(id)
        end
      end
    end
  end
end
