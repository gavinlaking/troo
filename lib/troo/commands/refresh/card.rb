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
          @resource ||= Card.remote(external_card_id, mode: :card)
        end

        def external_card_id
          local.external_card_id
        end

        def local
          @local ||= Card.retrieve(id)
        end
      end
    end
  end
end
