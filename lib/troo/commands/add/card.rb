module Troo
  module Commands
    module Add
      class Card < Resource
        def add
          if created
            success
          else
            error_trello_error
          end
        end

        private

        def success
          "New card '#{value}' created."
        end

        def error_trello_error
          "Card could not be created."
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
