module Troo
  module Persistence
    class List < Resource
      private

      def create
        Troo::List.create(remote_data)
      end

      def local
        @local ||= Troo::List.first(external_list_id: resource.id)
      end

      def remote_data
        @remote ||= Adaptors::List.adapt(resource)
      end
    end
  end
end
