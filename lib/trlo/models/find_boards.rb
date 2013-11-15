module Trlo
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
