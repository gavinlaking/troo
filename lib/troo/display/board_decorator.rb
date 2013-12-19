module Troo
  class BoardDecorator
    def initialize(board)
      @board = board
    end

    def short
      [current.center(3), id.rjust(6), name].join(" ") + "\n"
    end

    def name
      board.name
    end

    def current
      board.current? ? "*" : ""
    end

    def id
      brackets(board.id)
    end

    private
    attr_reader :board

    def brackets(value)
      "(#{value})"
    end
  end
end
