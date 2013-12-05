module Ctrlo
  class RefreshCards
    def initialize(board_id, options = {})
      @board_id = board_id
      @options  = options
    end

    def self.for(board_id, options = {})
      new(board_id, options).refresh
    end

    def refresh
      Card.persist ExternalCard.fetch_by_external_id(board_id, { mode: :board })
    end

    private
    attr_reader :board_id
  end
end
