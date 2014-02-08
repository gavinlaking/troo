module Troo
  module Commands
    module Show
      class Comments < Resource
        private

        def presenter
          resource.comment_presenter.show
        end

        def resource
          Retrieval::Card.retrieve(id)
        end
      end
    end
  end
end