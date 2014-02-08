module Troo
  module Commands
    module Status
      class Resource
        include CommandHelpers

        class << self
          def dispatch
            new.get_status
          end
        end

        def get_status
          return success if resource
          return error
        end

        private

        def resource_title
          resource.decorator.title
        end

        def plural(singular)
          count == 1 ? "#{count} #{singular}" : "#{count} #{singular}s"
        end
      end
    end
  end
end
