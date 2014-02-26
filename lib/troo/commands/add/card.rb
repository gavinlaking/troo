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
          return false if no_resource?
          @create ||= CreateCard.with(external_list_id, value)
        end

        def external_list_id
          resource.external_list_id
        end

        def resource
          @resource ||= Troo::List.retrieve(id)
        end
      end
    end
  end
end
