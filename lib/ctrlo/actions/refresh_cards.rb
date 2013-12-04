module Ctrlo
  class RefreshCards
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).refresh
    end

    def refresh
      Card.persist ExternalCard.request(board_id)
    end

    private
    attr_reader :board_id
  end
end
