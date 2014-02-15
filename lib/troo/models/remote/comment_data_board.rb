module Troo
  module Remote
    class CommentDataBoard
      include Virtus.model

      attribute :shortLink
      attribute :name
      attribute :id

      alias_method :short_link, :shortLink
    end
  end
end
