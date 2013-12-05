module Ctrlo
  class BoardDecorator
    def initialize(board)
      @board = board
    end

    def self.decorate(board)
      new(board).decorate
    end

    def decorate
      Template.parse(self)
    end

    def formatted_row
      [board_id.ljust(6), name].join
    end

    def board_id
      board.id
    end

    def name
      board.name
    end

    def template_file
      "/board_decorator.erb"
    end

    private
    attr_reader :board
  end
end
