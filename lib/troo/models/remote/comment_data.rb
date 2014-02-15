module Troo
  module Remote
    class CommentData
      include Virtus.model(:finalize => false)

      attribute :board, CommentDataBoard
      attribute :card,  CommentDataCard
      attribute :text
    end
  end
end
