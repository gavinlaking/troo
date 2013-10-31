module Trlo
  class ListPresenter
    def initialize(board_id)
      @board_id = board_id
    end

    def self.all(board_id)
      new(board_id).all
    end

    def all
      Screen.new(all_lists_header, all_lists_content).render
    end

    private
    attr_reader :board_id

    def all_lists_header
      { id: "ID", name: "Name" }
    end

    def all_lists_content
      Trello::Board.find(board_id).lists.map do |list|
        ListDecorator.new(list).to_hash
      end
    end
  end
end
