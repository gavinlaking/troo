module Troo
  module Commands
    module Add
      class Comment < Resource
        def add
          return success if created
          error_trello_error
        end

        private

        def success
          'New comment created.'
        end

        def error_trello_error
          'Comment could not be created.'
        end

        def created
          @created ||= CreateComment.for(resource, value)
        end

        def resource
          Card.retrieve(id)
        end
      end
    end
  end
end
