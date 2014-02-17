module Troo
  module Commands
    module Add
      class Card < Resource
        def add
          return success if created
          error_trello_error
        end

        private

        def success
          "New card '#{value}' created."
        end

        def error_trello_error
          'Card could not be created.'
        end

        def created
          @created ||= CreateCard.for(resource, value)
        end

        def resource
          List.retrieve(id)
        end
      end
    end
  end
end
