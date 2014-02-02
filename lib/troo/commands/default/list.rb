module Troo
  module Commands
    module Default
      class List
        include CommandHelpers

        class << self
          def dispatch(type, id = nil)
            new(type, id).set_default
          end
        end

        def initialize(type, id = nil)
          @type, @id = type, id
        end

        def set_default
          return success if resource && resource.set_default!
          error
        end

        private
        attr_reader :type, :id

        def success
          "'#{resource_name}' set as default list."
        end

        def error
          "List cannot be found."
        end

        def resource_name
          resource.decorator.name
        end

        def resource
          ListRetrieval.retrieve(id)
        end
      end
    end
  end
end
