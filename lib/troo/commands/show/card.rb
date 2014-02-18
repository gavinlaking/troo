module Troo
  module Commands
    module Show
      class Card < Resource
        private

        def resource
          Card.retrieve(id)
        end

        def type
          'card'
        end
      end
    end
  end
end
