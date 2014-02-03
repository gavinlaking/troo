module Troo
  module Commands
    module Add
      class Card < Resource
        def add
          if created
            success
          elsif created == false
            error_trello_error
          elsif no_default?
            error_no_default
          else
            error_not_found
          end
        end

        private

        def success
          "New card '#{value}' created."
        end

        def error_trello_error
          "Card could not be created."
        end

        def error_no_default
          "Specify an <id> or use 'troo default list <id>' to set a default list first."
        end

        def created
          @created ||= CreateCard.for(resource, value)
        end

        def resource
          Retrieval::List.retrieve(id)
        end
      end
    end
  end
end
