module Troo
  class BoardDecorator
    def initialize(board)
      @board = board
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
