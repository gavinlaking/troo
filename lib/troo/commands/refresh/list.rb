module Troo
  module Commands
    module Refresh
      class List < Resource
        private

        def type
          'list'
        end

        def resource
          return [] unless local
          @resource ||= Troo::List.remote(external_list_id, mode: :list)
        end

        def external_list_id
          local.external_list_id
        end

        def local
          @local ||= Troo::List.retrieve(id)
        end
      end
    end
  end
end
