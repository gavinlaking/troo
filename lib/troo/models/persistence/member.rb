module Troo
  module Persistence
    class Member < Resource
      private

      def create
        Troo::Member.create(remote_data)
      end

      def local
        @local ||= Troo::Member.first(external_member_id: resource.id)
      end

      def remote_data
        @remote ||= Adaptors::Member.adapt(resource)
      end
    end
  end
end
