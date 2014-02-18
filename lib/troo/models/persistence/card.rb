module Troo
  module Persistence
    class Card < Resource
      private

      def create
        Troo::Card.create(remote_data)
      end

      def local
        @local ||= Troo::Card.first(external_card_id: resource.id)
      end

      def remote_data
        @remote ||= Adaptors::Card.adapt(resource)
      end
    end
  end
end
