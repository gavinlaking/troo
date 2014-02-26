module Troo
  module Commands
    module Show
      class Card < Resource
        private

        def resource
          @resource ||= Troo::Card.retrieve(id)
        end

        def type
          'card'
        end
      end
    end
  end
end
