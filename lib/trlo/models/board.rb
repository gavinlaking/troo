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

  class FindBoard
    def initialize(board_id)
      @board_id = board_id
    end

    def self.with(board_id)
      new(board_id).find
    end

    def find
      Trello::Board.find(board_id)
    end

    private
    attr_reader :board_id
  end

  class FindBoards
    def initialize; end

    def self.all
      new.all_boards
    end

    def all_boards
      find_boards.map do |board|
        Board.decorate(board)
      end
    end

    private

    def find_boards
      Trello::Board.all
    end
  end
end
