module Troo
  module Commands
    module Status
      class List
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

        def success
          "  Lists:  " + plural("list") + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            "  Lists:  " + Esc.red + "No default list set." + Esc.reset
          else
            "  Lists:  No lists found.\n"
          end
        end

        def resource_title
          resource.decorator.title
        end

        def count
          @count ||= Troo::List.count
        end

        def resource
          @resource ||= ListRetrieval.default
        end

        def plural(singular)
          count == 1 ? "#{count} #{singular}" : "#{count} #{singular}s"
        end
      end
    end
  end
end
