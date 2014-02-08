module Troo
  module Commands
    module Status
      class Resource
        include CommandHelpers

        class << self
          def dispatch
            new.report_status
          end
        end

        def report_status
          return success if resource
          error
        end

        private

        def resource_title
          resource.decorator.title
        end

        def plural(singular)
          if count == 1
            "#{count} #{singular}"
          else
            "#{count} #{singular}s"
          end
        end
      end
    end
  end
end
