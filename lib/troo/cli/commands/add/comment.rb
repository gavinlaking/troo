module Troo
  module Commands
    module Add
      class Comment < Resource
        def add
          return success if create
          error
        end

        private

        def success
          'New comment created.'
        end

        def error
          'Comment could not be created.'
        end

        def create
          return false if no_resource?
          @create ||= Remote::Persistence::Comment
            .with(resource.external_id, value)
        end

        def resource
          @resource ||= Troo::Card.retrieve(id)
        end
      end
    end
  end
end
