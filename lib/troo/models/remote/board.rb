module Troo
  module Remote
    class Board
      include Virtus.model(finalize: false)
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :name
      attribute :desc
      attribute :descData
      attribute :closed,        Boolean
      attribute :idOrganization
      attribute :pinned
      attribute :url
      attribute :shortUrl
      attribute :prefs
      attribute :labelNames
      attribute :lists,         Array[Troo::Remote::List]
      attribute :cards,         Array[Troo::Remote::Card]
      attribute :members,       Array[Troo::Remote::Member]

      def associations
        [:lists, :cards, :members]
      end

      def local_model
        Troo::Board
      end

      def adaptor
        Adaptors::Board
      end
    end
  end
end
