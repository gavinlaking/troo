module Troo
  class BoardDecorator
    include DecoratorHelpers

    def initialize(board, options = {})
      @board = board
      @options = options
    end

    def short
      [default_str, id_str, name_str].join + "\n"
    end

    def name_str
      highlight(name, options)
    end

    def default_str
      default.center(3)
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

    def default
      board.default? ? "*" : ""
    end

    def id
      board.id.to_s
    end

    def lists(alt_options = {})
      board.lists.map { |list| list.decorator(alt_options) }
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
