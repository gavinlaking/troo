module Troo
  module Commands
    module Add
      class Card < Resource
        def add
          return success if create
          error
        end

        private

        def success
          "New card '#{value}' created."
        end

        def error
          'Card could not be created.'
        end

        def create
          @create ||= CreateCard.with(resource, value)
        end

        def resource
          @resource ||= Troo::List.retrieve(id)
        end
      end
    end
  end
end
