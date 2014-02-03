module Troo
  module Commands
    module Default
      class Resource
        include CommandHelpers

        attr_reader :id

        class << self
          def dispatch(id = nil)
            new(id).set_default
          end
        end

        def initialize(id = nil)
          @id = id
        end

        def set_default
          return success if resource && resource.set_default!
          error
        end
      end
    end
  end
end
