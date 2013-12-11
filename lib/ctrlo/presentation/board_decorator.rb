module Ctrlo
  class BoardDecorator
    def initialize(board)
      @board = board
    end

    def as_view
      Template.parse(self, "/../views/board.erb")
    end

    def as_list
      [Esc.underline, Esc.red, board_id, Esc.reset, " ", board_name].join
    end

    def short
      print Esc.underline + Esc.red
      print board_id
      print Esc.reset
      print " "
      print board_name
      print "\n"
    end

    def board_name
      board.name || "N/A"
    end

    def board_id
      board.id.to_s
    end

    private
    attr_reader :board
  end
end
