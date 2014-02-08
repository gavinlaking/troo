module Troo
  module Commands
    module Refresh
      class Card < Resource
        private

        def many_success
          'Multiple cards refreshed.'
        end

        def error
          return 'Default card cannot be found.' unless id
          @type = :card
          'Card cannot be found. ' + error_no_default
        end

        def resource
          return [] unless local
          @resource ||= External::Card.fetch(local.external_card_id,
                                             mode: :card)
        end

        def local
          @local ||= Retrieval::Card.retrieve(id)
        end
      end
    end
  end
end
