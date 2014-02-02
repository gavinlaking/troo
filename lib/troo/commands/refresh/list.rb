module Troo
  module Commands
    module Refresh
      class List
        include CommandHelpers

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
        attr_reader :type, :id

        def success
          "'#{resource_name}' refreshed."
        end

        def many_success
          "Multiple lists refreshed."
        end

        def error
          return "Default list cannot be found." unless id
          @type = :list
          "List cannot be found. " + error_no_default
        end

        def resource_name
          resource.first.decorator.name
        end

        def resource
          return [] unless local
          @resource ||= External::List.fetch(local.external_list_id, { mode: :list })
        end

        def local
          @local ||= Retrieval::List.retrieve(id)
        end
      end
    end
  end
end
