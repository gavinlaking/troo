module Troo
  module Commands
    module Status
      class Card < Resource
        private

        def count
          @count ||= Troo::Card.count
        end

        def resource
          @resource ||= Retrieval::Card.default
        end

        def type
          'card'
        end
      end
    end
  end
end
