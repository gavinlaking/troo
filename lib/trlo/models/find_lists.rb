module Trlo
  class FindLists
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).all_lists
    end

    def all_lists
      FindBoard.with(board_id).lists.map do |list|
        List.decorate(list)
      end
    end

    private
    attr_reader :board_id
  end
end
