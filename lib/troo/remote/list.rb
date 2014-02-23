module Troo
  module Remote
    class List
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :name
      attribute :closed,  Boolean
      attribute :idBoard
      attribute :pos,     Integer

      def associations
        []
      end

      def local_model
        Troo::List
      end

      def adaptor
        Adaptors::List
      end
    end
  end
end
