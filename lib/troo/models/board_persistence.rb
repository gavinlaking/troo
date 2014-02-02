module Troo
  module Persistence
    class Board < Resource
      private

      def created
        Troo::Board.create(remote_data)
      end

      def local
        @local ||= Troo::Board.first(external_board_id: resource.id)
      end

      def remote_data
        @remote ||= Troo::External::BoardAdaptor.adapt(resource)
      end
    end
  end
end
