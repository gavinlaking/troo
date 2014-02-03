module Troo
  module Commands
    module Refresh
      class Resource
        include CommandHelpers

        attr_accessor :type
        attr_reader :id

        class << self
          def dispatch(id = nil)
            new(id).refresh
          end
        end

        def initialize(id = nil)
          @id = id
        end

        def refresh
          if resource.one?
            success
          elsif resource.count > 1
            many_success
          else
            error
          end
        end

        private

        def success
          "'#{resource_name}' refreshed."
        end

        def resource_name
          resource.first.decorator.name
        end
      end
    end
  end
end
