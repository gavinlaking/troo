module Trlo
  class FindBoard
    def initialize(board_id)
      @board_id = board_id
    end

    def self.with(board_id)
      new(board_id).find
    end

    def find
      Trello::Board.find(board_id)
    end

    private
    attr_reader :board_id
  end
end
