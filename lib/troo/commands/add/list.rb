module Troo
  module Commands
    module Add
      class List
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
          "New list '#{created_name}' created."
        end

        def error_trello_error
          "List could not be created."
        end

        def created_name
          created.decorator.name
        end

        def created
          @created ||= CreateList.for(resource, value)
        end

        def resource
          BoardRetrieval.retrieve(id)
        end
      end
    end
  end
end
