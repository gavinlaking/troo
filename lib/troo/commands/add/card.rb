module Troo
  module Commands
    module Add
      class Card
        include CommandHelpers

        class << self
          def dispatch(value, id)
            new(value, id).add_resource
          end
        end

        def initialize(value, id)
          @value, @id = value, id
        end

        def add_resource
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
        attr_reader :id, :value

        def success
          "New card '#{created_name}' created."
        end

        def error_trello_error
          "Card could not be created."
        end

        def error_no_default
          "Specify an <id> or use 'troo default list <id>' to set a default list first."
        end

        def created_name
          created.decorator.name
        end

        def created
          @created ||= CreateCard.for(resource, value)
        end

        def resource
          ListRetrieval.retrieve(id)
        end
      end
    end
  end
end
