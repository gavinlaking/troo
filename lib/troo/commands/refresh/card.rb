module Troo
  module Commands
    module Refresh
      class Card < Resource
        private

        def type
          'card'
        end

        def resource
          return [] unless local
          @resource ||= Troo::Card
            .fetch(external_card_id, mode: :card)
        end

        def external_card_id
          local.external_card_id
        end

        def local
          @local ||= Troo::Card.retrieve(id)
        end
      end
    end
  end
end
