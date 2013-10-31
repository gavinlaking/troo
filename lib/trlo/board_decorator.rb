module Trlo
  class BoardDecorator
    def initialize(board)
      @board = board
    end

    def id
      board.id
    end

    def name
      board.name
    end

    def to_hash
      { id: id, name: name }
    end

    private
    attr_reader :board
  end
end
