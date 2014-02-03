module Troo
  module Commands
    module Show
      class Resource
        include CommandHelpers

        attr_reader :id, :type

        class << self
          def dispatch(type, id = nil)
            new(type, id).render
          end
        end

        def initialize(type, id = nil)
          @type, @id = type, id
        end

        def render
          if resource
            presenter
          elsif no_default?
            error_no_default
          else
            error_not_found
          end
        end

        private

        def presenter
          resource.presenter.show
        end
      end
    end
  end
end