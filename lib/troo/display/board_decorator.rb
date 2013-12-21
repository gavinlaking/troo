module Troo
  class BoardDecorator
    include DecoratorHelpers

    def initialize(board)
      @board = board
    end

    def short
      [current_str, id_str, name_str].join + "\n"
    end

    def name_str
      highlight(name, highlight_options)
    end

    def current_str
      current.center(3)
    end

    def id_str
      highlight(brackets(id) + " ", highlight_options).rjust(6)
    end

    def name
      (board.name && board.name.chomp) || "N/A"
    end

    def current
      board.current? ? "*" : ""
    end

    def id
      board.id.to_s
    end

    private
    attr_reader :board

    def highlight_options
      { colour: Esc.blue, underline: Esc.underline }
    end
  end
end
