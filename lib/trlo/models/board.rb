module Trlo
  class Board
    def initialize(board)
      @board = board
    end

    def self.decorate(board)
      new(board).decorate
    end

    def decorate
      { id: id, name: name, header: header }
    end

    def id
      board.id
    end

    def name
      board.name
    end

    private
    attr_reader :board

    def header
      { id: "ID", name: "Name" }
    end
  end
end

