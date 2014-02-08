module Troo
  module Commands
    module Refresh
      class List < Resource
        private

        def many_success
          'Multiple lists refreshed.'
        end

        def error
          return 'Default list cannot be found.' unless id
          @type = :list
          'List cannot be found. ' + error_no_default
        end

        def resource
          return [] unless local
          @resource ||= External::List.fetch(local.external_list_id,  mode: :list)
        end

        def local
          @local ||= Retrieval::List.retrieve(id)
        end
      end
    end
  end
end
