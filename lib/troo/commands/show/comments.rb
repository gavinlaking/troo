module Troo
  module Commands
    module Show
      class Comments < Resource
        private

        def presenter
          resource.comment_presenter.show
        end

        def resource
          Card.retrieve(id)
        end

        def type
          'card'
        end
      end
    end
  end
end
