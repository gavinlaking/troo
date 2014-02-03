module Troo
  module Commands
    module Add
      class Comment < Resource
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
