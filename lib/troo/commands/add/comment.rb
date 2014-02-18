module Troo
  module Commands
    module Add
      class Comment < Resource
        def add
          return success if created
          error
        end

        private

        def success
          'New comment created.'
        end

        def error
          'Comment could not be created.'
        end

        def created
          @created ||= CreateComment.with(resource, value)
        end

        def resource
          Troo::Card.retrieve(id)
        end
      end
    end
  end
end
