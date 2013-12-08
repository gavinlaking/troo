module Ctrlo
  class BoardDecorator
    def initialize(board)
      @board = board
    end

    def as_view
      Template.parse(self, "/board_decorator.erb")
    end

    def as_list_row
      [board_id, board_name].join
    end

    private
    attr_reader :board

    def board_name
      [ Esc.yellow, board.name, Esc.reset ].join
    end

    def board_id
      [ Esc.green, board_idstr, Esc.reset ].join
    end

    def board_idstr
      brackets(board.id.to_s).ljust(6)
    end

    def brackets(string = nil)
      "(" + string + ")"
    end
  end
end
