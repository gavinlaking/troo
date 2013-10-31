module Trlo
  class BoardPresenter
    def self.all
      new.all
    end

    def all
      Screen.new(all_boards_header, all_boards_content).render
    end

    private

    def all_boards_header
      { id: "ID", name: "Name" }
    end

    def all_boards_content
      Trello::Board.all.map do |board|
        BoardDecorator.new(board).to_hash
      end
    end
  end
end
