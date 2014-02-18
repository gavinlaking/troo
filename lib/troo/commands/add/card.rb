module Troo
  module Commands
    module Add
      class Card < Resource
        def add
          return success if created
          error
        end

        private

        def success
          "New card '#{value}' created."
        end

        def error
          'Card could not be created.'
        end

        def created
          @created ||= CreateCard.with(resource, value)
        end

        def resource
          List.retrieve(id)
        end
      end
    end
  end
end
