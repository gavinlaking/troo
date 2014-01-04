module Troo
  class BoardDecorator
    include DecoratorHelpers

    def initialize(board, options = {})
      @board = board
      @options = options
    end

    def short
      [current_str, id_str, name_str].join + "\n"
    end

    def name_str
      highlight(name, options)
    end

    def current_str
      current.center(3)
    end

    def id_str
      highlight(brackets(id) + " ", options).rjust(6)
    end

    def description
      return "N/A" if board.description.nil? || board.description.empty?
      word_wrap(board.description)
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

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        ansicolor: true,
        colour:    Esc.blue,
        underline: Esc.underline
      }
    end
  end
end
