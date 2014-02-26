module Troo
  module Remote
    class CommentDataCard
      include Virtus.model

      attribute :shortLink
      attribute :idShort
      attribute :name
      attribute :id

      alias_method :short_link, :shortLink
      alias_method :id_short,   :idShort
    end
  end
end
