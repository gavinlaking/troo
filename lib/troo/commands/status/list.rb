module Troo
  module Commands
    module Status
      class List
        include CommandHelpers

        class << self
          def dispatch(type, id = nil)
            new(type, id).get_status
          end
        end

        def initialize(type, id = nil)
          @type, @id = type, id
        end

        def get_status
          return success if resource
          return error
        end

        private
        attr_reader :type, :id

        def count
          @count = Troo::List.count
        end

        def success
          "  Lists:".ljust(10)    +
          plural(count, type_str) +
          " found.\n"             +
          "          #{resource_title}"
        end

        def error
          if count > 0
            Esc.red + "  Lists:  No default list set." + Esc.reset
          else
            "   Lists: " + "  No lists found.\n"
          end
        end

        def resource_title
          resource.decorator.title
        end

        def resource
          @resource ||= ListRetrieval.retrieve(id)
        end

        def plural(size, singular)
          case size
          when 0 then "No #{singular}s"
          when 1 then "#{size} #{singular}"
          else "#{size} #{singular}s"
          end
        end
      end
    end
  end
end
