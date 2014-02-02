module Troo
  module Commands
    module Add
      class Comment
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
          "New comment created."
        end

        def error_trello_error
          "Comment could not be created."
        end

        def error_no_default
          "Specify an <id> or use 'troo default card <id>' to set a default card first."
        end

        def created
          @created ||= CreateComment.for(resource, value)
        end

        def resource
          Retrieval::Card.retrieve(id)
        end
      end
    end
  end
end
