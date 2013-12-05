module Ctrlo
  class RefreshBoards
    def initialize(board_id, options = {})
      @board_id = board_id
      @options  = options
    end

    def self.for(board_id, options = {})
      new(board_id, options).refresh
    end

    def self.all
      Board.persist ExternalBoard.fetch
    end

    def refresh
      Board.persist ExternalBoard.fetch_by_external_id(board_id)
    end

    private
    attr_reader :board_id
  end
end
